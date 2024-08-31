import 'package:sharekhan_admin_panel/constants/asset_constants.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:sharekhan_admin_panel/widgets/common/custom_icon_button.dart';
import 'package:sharekhan_admin_panel/widgets/common/spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditTabFooter extends StatelessWidget {
  final String goBackrouteName;
  final VoidCallback onSave;
  const EditTabFooter(
      {super.key, required this.goBackrouteName, required this.onSave});

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
            CustomIconButton(
              onTap: onSave,
              text: 'Save',
              fillColor: AppTheme.colorRed,
              textColor: AppTheme.colorWhite,
              icon: iconSave,
            )
          ],
        ),
        const Spacing(size: AppTheme.spacingMedium),
      ],
    );
  }
}
