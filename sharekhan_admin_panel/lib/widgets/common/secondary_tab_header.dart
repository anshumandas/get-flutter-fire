import 'package:sharekhan_admin_panel/constants/asset_constants.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:sharekhan_admin_panel/widgets/common/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BreadcrumbTabHeader extends StatelessWidget {
  final String mainTitle;
  final String secondaryTitle;
  final String goBackRoute;
  const BreadcrumbTabHeader(
      {super.key,
      required this.goBackRoute,
      required this.mainTitle,
      required this.secondaryTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => context.go(goBackRoute),
          hoverColor: Colors.transparent,
          child: Text(
            mainTitle,
            style: AppTheme.fontStyleDefaultBold.copyWith(
                fontSize: AppTheme.fontSizeLarge, color: AppTheme.colorGrey),
          ),
        ),
        Padding(
          padding: AppTheme.paddingSymetricHorizontal.copyWith(
              left: AppTheme.spacingTiny, right: AppTheme.spacingTiny),
          child: const CustomIcon(
            asset: iconChevronRight,
            color: AppTheme.colorGrey,
          ),
        ),
        Text(
          secondaryTitle,
          style: AppTheme.fontStyleDefaultBold.copyWith(
            fontSize: AppTheme.fontSizeLarge,
          ),
        )
      ],
    );
  }
}
