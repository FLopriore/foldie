import 'dart:developer';
import 'dart:io';
import 'package:foldie/providers/devices_provider.dart';
import 'package:foldie/utils/error_message.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MacFilePicker extends StatefulWidget {
  const MacFilePicker({super.key});

  @override
  State<MacFilePicker> createState() => _MacFilePickerState();
}

class _MacFilePickerState extends State<MacFilePicker> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
        text: path.absolute(Platform.environment['HOME']!));
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<DevicesState>();
    return Row(
      children: [
        const CupertinoNavigationBarBackButton(
          color: CupertinoColors.inactiveGray,
        ),
         Expanded(
          flex: 10,
          child: CupertinoTextField(
            controller: _textController,
            decoration: const BoxDecoration(
              color: CupertinoColors.inactiveGray,
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
            onSubmitted: (pathDirectory) {
              bool existPath = Directory(pathDirectory).existsSync();
              if (!existPath) {
                ErrorMessage.showErrorDialog(
                    context,
                    "Directory doesn't exist",
                    "Use a valid path."
                );
              }
            },
          ),
        ),
        const SizedBox(width: 10),
        CupertinoButton.filled(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text(
              "Browse...",
              style: TextStyle(
                  color: CupertinoColors.white, fontSize: 16),
            ),
            onPressed: () async {
              try {
                _textController.text = await appState.getPathOnMac();
              } catch (e) {
                log(e.toString());
              }
            }),
      ],
    );
  }
}
