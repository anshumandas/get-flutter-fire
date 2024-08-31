import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:sharekhan_admin_panel/widgets/common/custom_icon.dart';
import 'package:sharekhan_admin_panel/widgets/common/spacing.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String icon;
  final Color fillColor;
  final Color textColor;
  final Color borderColor;
  final Color iconColor;
  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.fillColor,
    required this.textColor,
    this.borderColor = Colors.transparent,
    required this.icon,
    this.iconColor = AppTheme.colorWhite,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingSmall,
          vertical: AppTheme.spacingTiny,
        ),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: AppTheme.borderRadius,
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            CustomIcon(
              asset: icon,
              color: iconColor,
            ),
            const Spacing(
              size: AppTheme.spacingTiny,
              isHorizontal: true,
            ),
            Text(
              text,
              style:
                  AppTheme.fontStyleHeadingDefault.copyWith(color: textColor),
            )
          ],
        ),
      ),
    );
  }
}
