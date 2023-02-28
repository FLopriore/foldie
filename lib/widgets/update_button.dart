import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foldie/providers/devices_provider.dart';
import 'package:provider/provider.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<DevicesState>();
    return Material(
      color: CupertinoTheme.of(context).scaffoldBackgroundColor,
      child: IconButton(
        icon: const Icon(
          CupertinoIcons.refresh,
          color: Color(0x80ffffff),
        ),
        onPressed: () => appState.getAdbDevices(),
        iconSize: 24,
      ),
    );
  }
}
