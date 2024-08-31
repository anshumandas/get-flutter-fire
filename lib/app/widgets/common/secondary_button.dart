import 'package:flutter/material.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool disabled;

  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? null : onPressed,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: AppTheme.fontStyleHeadingDefault.copyWith(
            fontWeight: FontWeight.bold,
            color: disabled ? AppTheme.greyTextColor : AppTheme.colorRed,
            decoration: TextDecoration.underline,
            decorationColor:
                disabled ? AppTheme.greyTextColor : AppTheme.colorRed),
      ),
    );
  }
}
