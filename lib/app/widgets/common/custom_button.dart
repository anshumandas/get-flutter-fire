import 'package:flutter/material.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isDisabled;

  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: isDisabled ? AppTheme.colorDisabled : AppTheme.colorRed,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: AppTheme.fontStyleDefaultBold.copyWith(
            color: AppTheme.colorWhite,
          ),
        ),
      ),
    );
  }
}
