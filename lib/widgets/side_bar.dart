import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foldie/providers/devices_provider.dart';
import 'package:provider/provider.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<DevicesState>();
    return Material(
      color: CupertinoTheme.of(context).scaffoldBackgroundColor,
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          ListTile(
            leading: const Icon(
              CupertinoIcons.arrow_up_circle,
              color: Colors.white,
            ),
            title: const Text(
              'Copy to phone',
              style: TextStyle(color: Colors.white),
            ),
            selectedTileColor: CupertinoColors.activeBlue,
            selected: appState.transferMode == TransferMode.macToPhone,
            onTap: () {
              appState.changeTransferMode(TransferMode.macToPhone);
            },
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.arrow_down_circle,
              color: Colors.white,
            ),
            title: const Text(
              'Copy to Mac',
              style: TextStyle(color: Colors.white),
            ),
            selectedTileColor: CupertinoColors.activeBlue,
            selected: appState.transferMode == TransferMode.phoneToMac,
            onTap: () {
              appState.changeTransferMode(TransferMode.phoneToMac);
            },
          )
        ],
      ),
    );
  }
}