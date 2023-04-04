import 'package:flutter/cupertino.dart';
import 'package:foldie/enums/transfer_mode.dart';
import 'package:foldie/providers/devices_provider.dart';
import 'package:foldie/utils/error_message.dart';
import 'package:provider/provider.dart';

class TransferButton extends StatefulWidget {
  const TransferButton({Key? key}) : super(key: key);

  @override
  State<TransferButton> createState() => _TransferButtonState();
}

class _TransferButtonState extends State<TransferButton> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<DevicesState>();
    return ValueListenableBuilder(
      valueListenable: isLoading,
      builder: (context, value, child) {
        return SizedBox(
          width: 300,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CupertinoButton.filled(
                onPressed: (value)
                    ? null // disable onPressed while is loading
                    : () async {
                        isLoading.value = true;
                        int exitCode = await appState.transferFiles();
                        if (exitCode == 1 && context.mounted) {
                          ErrorMessage.showErrorDialog(
                            context,
                            "Transfer Error",
                            "Try again or replug your phone."
                          );
                        }
                        isLoading.value = false;
                      },
                child: Text(
                  (appState.transferMode == TransferMode.phoneToMac)
                      ? "Copy to Mac"
                      : "Copy to phone",
                  style: const TextStyle(color: CupertinoColors.white),
                ),
              ),
              if (value) // show indicator only while loading
                const Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoActivityIndicator(),
                ),
            ],
          ),
        );
      },
    );
  }
}
