import 'package:sharekhan_admin_panel/constants/asset_constants.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:sharekhan_admin_panel/widgets/common/custom_icon_button.dart';
import 'package:sharekhan_admin_panel/widgets/common/spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddTabFooter extends StatelessWidget {
  final String goBackrouteName;
  final String buttonText;
  final VoidCallback onAdd;
  final VoidCallback onReset;
  const AddTabFooter({
    super.key,
    required this.goBackrouteName,
    required this.onAdd,
    required this.onReset,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: AppTheme.borderColor, thickness: 1),
        const Spacing(size: AppTheme.spacingSmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIconButton(
              onTap: () => context.go(goBackrouteName),
              text: 'Go Back',
              fillColor: AppTheme.colorWhite,
              textColor: AppTheme.colorBlack,
              borderColor: AppTheme.colorBlack,
              iconColor: AppTheme.colorBlack,
              icon: iconBack,
            ),
            Row(
              children: [
                CustomIconButton(
                  onTap: onReset,
                  text: 'Reset Information',
                  fillColor: AppTheme.colorBlack,
                  textColor: AppTheme.colorWhite,
                  icon: iconTrial,
                ),
                const Spacing(size: AppTheme.spacingSmall, isHorizontal: true),
                CustomIconButton(
                  onTap: onAdd,
                  text: buttonText,
                  fillColor: AppTheme.colorRed,
                  textColor: AppTheme.colorWhite,
                  icon: iconAdd,
                ),
              ],
            )
          ],
        ),
        const Spacing(size: AppTheme.spacingMedium),
      ],
    );
  }
}
