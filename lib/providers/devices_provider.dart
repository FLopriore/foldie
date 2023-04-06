import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:foldie/enums/transfer_mode.dart';
import 'package:foldie/utils/adb_commands.dart';

class DevicesState extends ChangeNotifier {
  List<String> attachedDevicesList = <String>[]; // list with attached devices
  String selectedDevice = "";
  String currentPhonePath = "/storage/emulated/0";
  String currentMacPath = path.absolute(Platform.environment['HOME']!);
  List<String> filesList = <String>[];
  String selectedFile = "";
  TransferMode transferMode = TransferMode.macToPhone;

  // Runs 'adb devices' command to get all the attached devices and adds
  // them in availableDevicesList.
  void getAdbDevices() async {
    String adbDevices = await AdbCommands.getAdbCommand(["devices"]);

    // Removes "List of devices attached" from adbDevices.
    adbDevices = adbDevices.substring(25);

    if (adbDevices != "\n") {
      if (attachedDevicesList.isNotEmpty) {
        attachedDevicesList.clear();
      }
      // Adds devices to the list.
      _addDevicesInList(adbDevices);
      // Selects the first device of the list by default.
      selectedDevice = attachedDevicesList.elementAt(0);
    } else {
      // Remove any previously-attached device from the list.
      attachedDevicesList.clear();
      selectedDevice = "";
    }
    notifyListeners();
  }

  // Selects the attached device linked to the index.
  void selectDevice(int index) {
    selectedDevice = attachedDevicesList.elementAt(index);
    notifyListeners();
  }

  // Converts the output of 'adb devices' into a list.
  void _addDevicesInList(String adbDevices) {
    const String end = "device";
    while (adbDevices != "\n") {
      final int endIndex = adbDevices.indexOf(end);
      String deviceSerial =
          adbDevices.substring(0, endIndex - 1); // serial number of the device

      // Adds the serial number of the device to availableDevicesList.
      attachedDevicesList.add(deviceSerial);

      String remainingDevices =
          adbDevices.substring(endIndex + end.length + 1); // remaining string
      adbDevices = remainingDevices;
    }
  }

  // Runs the command 'adb shell ls /name/of/the/path' to get all the folders
  // and files in the current path.
  void getFilesInPath() async {
    String phonePath = currentPhonePath;
    if (phonePath.contains(" ")) {
      // avoid problems with paths containing spaces
      phonePath = phonePath.replaceAll(" ", "\\ ");
    }
    String filesInPath = await AdbCommands.getAdbCommand(
        ["-s", selectedDevice, "shell", "ls", phonePath]
    );
    if (filesInPath.isNotEmpty) {
      if (filesList.isNotEmpty) {
        filesList.clear();
      }
      _addFilesInList(filesInPath);
    } else {
      filesList.clear();
      selectedFile = "";
    }
    notifyListeners();
  }

  // Converts the output of 'adb shell ls /name/of/the/path' into a list.
  void _addFilesInList(String filesInPath) {
    while (filesInPath.isNotEmpty) {
      final int endIndex = filesInPath.indexOf("\n");
      String element = filesInPath.substring(0, endIndex); // file or folder
      filesList.add(element);
      String remainingFiles =
          filesInPath.substring(endIndex + 1); // remaining string
      filesInPath = remainingFiles;
    }
  }

  // Selects the file or folder linked to the index.
  void selectFile(int index) {
    selectedFile = filesList.elementAt(index);
    notifyListeners();
  }

  // Changes the mode in which files are transferred.
  // phoneToMac invokes 'adb pull' command.
  // macToPhone invokes 'adb push' command.
  void changeTransferMode(TransferMode mode) {
    if (mode != transferMode) {
      transferMode = mode;
      notifyListeners();
    }
  }

  // Chooses a file or directory on your Mac.
  // If transferMode is phoneToMac, it chooses a directory where to transfer
  // files coming from your phone.
  // If transferMode is macToPhone, it chooses a file to send to your phone.
  Future<String> getPathOnMac() async {
    const String confirmButtonText = 'Choose';
    final String? elementPath;
    if (transferMode == TransferMode.phoneToMac) {
      elementPath = await getDirectoryPath(
        confirmButtonText: confirmButtonText,
      );
    } else {
      final XFile? file = await openFile(
        confirmButtonText: confirmButtonText,
      );
      elementPath = file?.path;
    }
    if (elementPath == null) {
      // Operation was canceled by the user.
      throw "No path selected by the user!";
    }
    currentMacPath = elementPath;
    notifyListeners();
    return elementPath;
  }

  // Transfers files using adb push/pull.
  // Returns the exit code of the command to catch any possible errors.
  Future<int> transferFiles() async {
    List<String> adbTransferArgs = (transferMode == TransferMode.phoneToMac)
        ? ["pull", "$currentPhonePath/$selectedFile", currentMacPath]
        : ["push", currentMacPath, currentPhonePath];
    int adbExitCode = await AdbCommands.adbCmdWithExitCode(adbTransferArgs);
    getFilesInPath();
    notifyListeners();
    return adbExitCode;
  }

  // Moves to the parent directory on your phone.
  // If the current path is /sdcard, it doesn't go any further.
  void moveToParentDirectory() {
    if (currentPhonePath != "/storage/emulated/0") {
      // Find the index of the last "/" to remove the name of the current
      // folder from the path.
      int index = currentPhonePath.lastIndexOf("/");
      currentPhonePath = currentPhonePath.substring(0, index);
      getFilesInPath();
    }
  }
}
