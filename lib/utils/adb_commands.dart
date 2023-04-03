import 'dart:io';

class AdbCommands {
  /// It invokes the 'adb' command with the arguments specified in [args].
  static Future<String> getAdbCommand(List<String> args) async {
    var process = await Process.run('adb', args);
    String adbCommandOutput = process.stdout;
    return adbCommandOutput;
  }
}
