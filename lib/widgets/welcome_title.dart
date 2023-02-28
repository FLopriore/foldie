import 'package:flutter/cupertino.dart';

class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({
    super.key, required this.style,
  });

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        "Easily transfer files\nbetween\nAndroid and Mac",
        textAlign: TextAlign.center,
        style: style.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 50,
        ),
      ),
    );
  }
}