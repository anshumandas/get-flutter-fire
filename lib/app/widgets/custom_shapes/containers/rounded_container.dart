import 'package:flutter/material.dart';
import 'package:streakzy/utils/constants/colors.dart';
import 'package:streakzy/utils/constants/sizes.dart';

class SRoundedContainer extends StatelessWidget {
  const SRoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.radius = SSizes.cardRadiusLg,
    this.padding,
    this.backgroundColor = SColors.white,
    this.margin,
    this.showBorder = false,
    this.borderColor = SColors.borderPrimary,
  });

  final double? width;
  final double? height;
  final double radius;
  final bool showBorder;
  final Color borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Color backgroundColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}