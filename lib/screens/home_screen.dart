import 'package:flutter/cupertino.dart';
import 'package:foldie/providers/devices_provider.dart';
import 'package:foldie/screens/available_devices_screen.dart';
import 'package:foldie/widgets/welcome_title.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<DevicesState>();
    var theme = CupertinoTheme.of(context);
    var style = theme.textTheme.textStyle;

    return CupertinoPageScaffold(
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WelcomeTitle(style: style),
              const SizedBox(height: 10),
              CupertinoButton.filled(
                child: Text("Find devices", style: style,),
                onPressed: () {
                  appState.getAdbDevices(); // gets list of attached devices
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const AvailableDevicesPage(),
                    ),
                  );
                },
              ),
            ],
          )
      ),
    );
  }
}