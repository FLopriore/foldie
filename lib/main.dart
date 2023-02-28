import 'package:flutter/cupertino.dart';
import 'package:foldie/screens/home_screen.dart';
import 'package:foldie/providers/devices_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DevicesState(),
      child: const CupertinoApp(
        title: 'Foldie',
        theme: CupertinoThemeData(
          primaryColor: CupertinoColors.activeBlue,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Color(0xff181818),
        ),
        home: MyHomePage(),
      ),
    );
  }
}
