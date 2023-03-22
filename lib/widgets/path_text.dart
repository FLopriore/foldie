import 'package:flutter/cupertino.dart';

class PathText extends StatelessWidget {
  final String path;

  const PathText({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Shorten phone path
    String shortPath =
        path.replaceAll(RegExp("/storage/emulated/0"), "/sdcard");
    return Text(
      shortPath,
      style: const TextStyle(
        color: CupertinoColors.inactiveGray,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
