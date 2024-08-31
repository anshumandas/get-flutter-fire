import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color fillColor;
  final Color textColor;
  final Color borderColor;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.fillColor,
    this.borderColor = Colors.transparent,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: AppTheme.paddingTiny,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: AppTheme.borderRadius,
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTheme.fontStyleSmall.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
