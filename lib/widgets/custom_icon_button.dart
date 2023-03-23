import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Function()? onPressed;
  final double iconSize;
  final Color color;

  const CustomIconButton(
      {Key? key,
        this.iconSize = 24,
        this.color = const Color(0x80ffffff),
        required this.icon,
        required this.onPressed,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CupertinoTheme.of(context).scaffoldBackgroundColor,
      child: IconButton(
        icon: Icon(
          icon,
          color: color,
        ),
        onPressed: onPressed,
        iconSize: iconSize,
      ),
    );
  }
}
