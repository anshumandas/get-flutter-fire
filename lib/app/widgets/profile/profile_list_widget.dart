import 'package:flutter/material.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class ProfileListItem extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final String text;
  final Function() onTap;

  const ProfileListItem({
    super.key,
    this.icon,
    this.imagePath,
    required this.text,
    required this.onTap,
  }) : assert(icon != null || imagePath != null,
            'Either icon or image must be provided');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: icon != null
              ? Icon(icon, color: AppTheme.greyTextColor)
              : imagePath != null
                  ? Image.asset(imagePath!, width: 24, height: 24)
                  : null,
          title: Text(text,
              style: AppTheme.fontStyleDefaultBold.copyWith(
                color: AppTheme.greyTextColor,
              )),
          trailing: const Icon(Icons.arrow_forward_ios,
              color: AppTheme.colorBlack, size: AppTheme.fontSizeSmall),
          onTap: onTap,
        ),
        const Divider(color: AppTheme.borderColor, height: 0.5),
      ],
    );
  }
}
