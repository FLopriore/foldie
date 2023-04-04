import 'dart:io';

class AdbCommands {
  /// Invokes the 'adb' command with the arguments specified in [args].
  static Future<String> getAdbCommand(List<String> args) async {
    var process = await Process.run('adb', args);
    return process.stdout;
  }

  /// Same as [getAdbCommand], but returns the exit code.
  static Future<int> adbCmdWithExitCode(List<String> args) async {
    var process = await Process.run('adb', args);
    return process.exitCode;
  }
}
