import 'package:flutter/cupertino.dart';

/// Creates a custom icon from the asset [icon].
///
/// By default, [height] and [width] are set to 32.
/// Color is null in order to use the original colors of the file.
class CustomIcon extends StatelessWidget {
  final String icon;
  final double height;
  final double width;

  const CustomIcon(
      {Key? key, required this.icon, this.height = 32, this.width = 32})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(icon),
      color: null,
      height: height,
      width: width,
    );
  }
}
