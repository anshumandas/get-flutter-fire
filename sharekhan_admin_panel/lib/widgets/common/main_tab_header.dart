import 'package:sharekhan_admin_panel/constants/asset_constants.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:sharekhan_admin_panel/widgets/common/custom_icon_button.dart';
import 'package:sharekhan_admin_panel/widgets/common/spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainTabHeader extends StatelessWidget {
  final String title;
  final String secondButtonText;
  final String routeName;
  final VoidCallback onExport;
  final bool showExportButton;
  final bool showSecondButton;
  const MainTabHeader({
    super.key,
    required this.title,
    required this.routeName,
    required this.secondButtonText,
    required this.onExport,
    this.showExportButton = true,
    this.showSecondButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTheme.fontStyleDefaultBold.copyWith(
            fontSize: AppTheme.fontSizeLarge,
          ),
        ),
        Row(
          children: [
            if (showExportButton)
              CustomIconButton(
                onTap: onExport,
                text: 'Export',
                icon: iconExport,
                fillColor: AppTheme.colorBlack,
                textColor: AppTheme.colorWhite,
              ),
            if (showSecondButton) ...[
              const Spacing(size: AppTheme.spacingSmall, isHorizontal: true),
              CustomIconButton(
                onTap: () => context.go(routeName),
                text: secondButtonText,
                icon: iconAdd,
                fillColor: AppTheme.colorRed,
                textColor: AppTheme.colorWhite,
              ),
            ],
          ],
        )
      ],
    );
  }
}
