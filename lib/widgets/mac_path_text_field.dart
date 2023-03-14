import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:flutter/cupertino.dart';

class MacPathTextField extends StatefulWidget {
  const MacPathTextField({super.key});

  @override
  State<MacPathTextField> createState() => _MacPathTextFieldState();
}

class _MacPathTextFieldState extends State<MacPathTextField> {
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
    return CupertinoTextField(
      controller: _textController,
      decoration: const BoxDecoration(
        color: CupertinoColors.inactiveGray,
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
      ),
      onSubmitted: (pathDirectory) {
        bool existPath = Directory(pathDirectory).existsSync();
        if (!existPath) {
          _showAlertDialog(context);
        }
      },
    );
  }

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("Directory doesn't exist"),
        content: const Text("Use a valid path"),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
