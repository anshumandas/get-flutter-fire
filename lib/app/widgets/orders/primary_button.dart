import 'package:flutter/material.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool disabled;
  final bool smallBorder;

  final bool isOutlined;
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.disabled = false,
    this.smallBorder = false,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: AppTheme.borderRadius,
      color: disabled
          ? AppTheme.backgroundColor
          : isOutlined
              ? Colors.transparent
              : AppTheme.colorRed,
      child: InkWell(
        onTap: disabled ? null : onPressed,
        child: Container(
          height: AppTheme.spacingExtraLarge,
          decoration: BoxDecoration(
            borderRadius: AppTheme.borderRadius,
            border: isOutlined
                ? Border.all(
                    color: AppTheme.colorRed,
                  )
                : null,
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: AppTheme.fontStyleHeadingDefault.copyWith(
                color: disabled
                    ? AppTheme.greyTextColor
                    : isOutlined
                        ? AppTheme.colorBlue
                        : AppTheme.colorWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
