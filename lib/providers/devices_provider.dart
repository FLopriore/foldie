import 'package:flutter/cupertino.dart';
import 'package:foldie/utils/adb_commands.dart';

class DevicesState extends ChangeNotifier {
  List<String> attachedDevicesList = []; // list with attached devices
  String selectedDevice = "";
  String currentPath = "/storage/emulated/0";
  List<String> filesList = [];
  List<String> parentPathFileList = [];
  String selectedFile = "";

  // Runs 'adb devices' command to get all the attached devices and adds
  // them in availableDevicesList.
  void getAdbDevices() async {
    String adbDevices = await AdbCommands.getAdbCommand("devices");

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
  // and files in the current path and
  void getFilesInPath() async {
    String filesInPath = await AdbCommands.getAdbCommand(
        "-s $selectedDevice shell ls $currentPath");

    if (filesList.isNotEmpty) {
      filesList.clear();
    }

    _addFilesInList(filesInPath);
    selectedFile = filesList.elementAt(0);

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
}
