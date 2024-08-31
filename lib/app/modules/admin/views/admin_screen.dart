import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:get_flutter_fire/theme/assets.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<AuthController>();

    final List<Map<String, dynamic>> adminItems = [
      {
        'imagePath': iconProfile,
        'text': 'Approve Sellers',
        'onTap': () {
          // Navigate to the screen where the admin can approve sellers
          Get.toNamed(Routes.APPROVE_SELLERS);
        }
      },
      {
        'imagePath': iconLocation,
        'text': 'Upload Banners',
        'onTap': () {
          // Navigate to the screen where the admin can upload banners
          Get.toNamed(Routes.UPLOAD_BANNERS);
        }
      },
      {
        'imagePath': iconFile,
        'text': 'View Categories',
        'onTap': () {
          // Navigate to the screen where the admin can add categories
          Get.toNamed(Routes.VIEW_CATEGORIES);
        }
      },
      {
        'imagePath': iconProfile,
        'text': 'check Banners',
        'onTap': () {
          // Navigate to the screen where the admin can approve sellers
          Get.toNamed(Routes.EDIT_BANNER);
        }
      },
    ];

    return Scaffold(
      backgroundColor: AppTheme.colorRed,
      body: Column(
        children: [
          const Spacing(size: AppTheme.spacingMedium),
          Expanded(
            child: Container(
              padding: AppTheme.paddingTiny,
              decoration: const BoxDecoration(
                color: AppTheme.colorWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: adminItems.length,
                      itemBuilder: (context, index) {
                        final item = adminItems[index];
                        return Column(
                          children: [
                            if (index == 0)
                              const Spacing(size: AppTheme.spacingTiny),
                            AdminListItem(
                              imagePath: item['imagePath'],
                              text: item['text'],
                              onTap: item['onTap'],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: AppTheme.paddingDefault,
                    child: RichText(
                      text: TextSpan(
                        style: AppTheme.fontStyleDefaultBold
                            .copyWith(color: AppTheme.greyTextColor),
                        children: [
                          const TextSpan(text: 'Admin Panel Managed by '),
                          TextSpan(
                            text: 'BasedHarsh',
                            style: AppTheme.fontStyleDefaultBold
                                .copyWith(color: AppTheme.colorRed),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdminListItem extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;

  const AdminListItem({
    super.key,
    required this.imagePath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.asset(
        imagePath,
        width: 30,
        height: 30,
        color: AppTheme.colorRed,
      ),
      title: Text(
        text,
        style:
            AppTheme.fontStyleDefaultBold.copyWith(color: AppTheme.colorBlack),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppTheme.greyTextColor,
      ),
    );
  }
}
