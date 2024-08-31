import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final String asset;
  final double width;
  final double height;
  final Color? color;

  const CustomIcon({
    super.key,
    required this.asset,
    this.width = 24.0,
    this.height = 24.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      height: height,
      width: width,
      color: color,
    );
  }
}
