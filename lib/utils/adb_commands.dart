import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class AdbCommands {
  /// Invokes the 'adb' command with the arguments specified in [args].
  static Future<String> getAdbCommand(List<String> args) async {
    File adbFile = await _getAdbFromAssets();
    String adbPath = adbFile.absolute.path;
    var process = await Process.run(adbPath, args, runInShell: true);
    return process.stdout;
  }

  /// Same as [getAdbCommand], but returns the exit code.
  static Future<int> adbCmdWithExitCode(List<String> args) async {
    File adbFile = await _getAdbFromAssets();
    String adbPath = adbFile.absolute.path;
    var process = await Process.run(adbPath, args, runInShell: true);
    return process.exitCode;
  }

  /// Loads adb executable from assets and adds it into a temporary directory.
  /// Returns the temporary file that has just been created.
  ///
  /// Credits: https://stackoverflow.com/a/74134379
  static Future<File> _getAdbFromAssets() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = "$tempPath/adb";
    var file = File(filePath);
    if (file.existsSync()) {
      await Process.run('chmod', ['755', filePath]);
      return file;
    } else {
      final byteData = await rootBundle.load('assets/adb');
      final buffer = byteData.buffer;
      await file.create(recursive: true);
      await Process.run('chmod', ['755', filePath]);
      return file
          .writeAsBytes(buffer.asUint8List(byteData.offsetInBytes,
          byteData.lengthInBytes));
    }
  }
}
