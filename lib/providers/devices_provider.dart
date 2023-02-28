import 'package:flutter/cupertino.dart';
import 'package:foldie/utils/adb_commands.dart';

class DevicesState extends ChangeNotifier {
  List<String> attachedDevicesList = []; // list with attached devices
  String selectedDevice = "";

  // It runs 'adb devices' command to get all the attached devices and adds
  // them in availableDevicesList.
  void getAdbDevices() async {
    String adbDevices = await AdbCommands.getAdbCommand("devices");

    // remove "List of devices attached" from adbDevices
    adbDevices = adbDevices.substring(25);

    if (adbDevices != "\n") {
      if (attachedDevicesList.isNotEmpty) {
        attachedDevicesList.clear();
      }
      _addDevicesInList(adbDevices); //add devices to the list
      // select the first device of the list by default
      selectedDevice = attachedDevicesList.elementAt(0);
    } else {
      attachedDevicesList.clear();
      selectedDevice = "";
    }
    notifyListeners();
  }

  // It selects the attached device linked to the index.
  void selectDevice(int index) {
    selectedDevice = attachedDevicesList.elementAt(index);
    notifyListeners();
  }

  // It converts the output of 'adb devices' into readable
  void _addDevicesInList(String adbDevices) {
    const String end = "device";
    while (adbDevices != "\n") {
      final int endIndex = adbDevices.indexOf(end);
      String deviceSerial =
          adbDevices.substring(0, endIndex - 1); // serial number of the device

      // add the serial number of the device to availableDevicesList
      attachedDevicesList.add(deviceSerial);

      String remainingDevices =
          adbDevices.substring(endIndex + end.length + 1); // remaining string
      adbDevices = remainingDevices;
    }
  }
}
