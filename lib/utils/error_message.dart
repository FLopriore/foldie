import 'package:flutter/cupertino.dart';

class ErrorMessage {
  /// Shows an alert dialog if there are any errors.
  static void showErrorDialog(BuildContext context, String title, String content) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) =>
          CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }
}