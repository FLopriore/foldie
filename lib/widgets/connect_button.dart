import 'package:flutter/cupertino.dart';
import 'package:foldie/providers/devices_provider.dart';
import 'package:provider/provider.dart';

class ConnectButton extends StatelessWidget {
  const ConnectButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<DevicesState>();
    return CupertinoButton.filled(
      onPressed: appState.selectedDevice.isEmpty ? null : _pushConnect,
      child: Text(
        'Connect',
        style: CupertinoTheme.of(context).textTheme.textStyle,
      ),
    );
  }

  _pushConnect() {

  }
}
