import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foldie/providers/devices_provider.dart';
import 'package:provider/provider.dart';

class DevicesListView extends StatefulWidget {
  const DevicesListView({super.key});

  @override
  State<DevicesListView> createState() => _DevicesListViewState();
}

class _DevicesListViewState extends State<DevicesListView> {
  int _selectedDeviceIndex = 0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<DevicesState>();
    TextStyle textStyle = CupertinoTheme.of(context).textTheme.textStyle;
    Widget content;

    if (appState.attachedDevicesList.isEmpty) {
      content = Center(
        child: Text(
          'No attached devices.',
          style: textStyle,
        ),
      );
    } else {
      content = ListView.builder(
        itemCount: appState.attachedDevicesList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              appState.attachedDevicesList.elementAt(index),
              style: textStyle,
            ),
            selected: index == _selectedDeviceIndex,
            onTap: () {
              _selectedDeviceIndex = index;
              appState.selectDevice(index);
            },
            trailing: Icon(
              (_selectedDeviceIndex == index)
                  ? CupertinoIcons.checkmark_alt_circle_fill
                  : CupertinoIcons.checkmark_alt_circle,
            ),
            iconColor: Colors.white,
          );
        },
      );
    }

    return SizedBox(
      width: 300,
      height: 300,
      child: Material(
        color: const Color(0xff3a3a3c),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: content,
      ),
    );
  }
}
