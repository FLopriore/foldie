import 'package:flutter/services.dart';

class AdbCommands {
  static const adbChannel = MethodChannel('com.foldie/adb');

  /// It invokes the 'adb' command with the arguments specified in [args].
  static Future<String> getAdbCommand(String args) async {
    final arguments = {'command': args};
    final String adbCommandOutput =
        await adbChannel.invokeMethod('getAdbCommand', arguments);
    return adbCommandOutput;
  }
}
