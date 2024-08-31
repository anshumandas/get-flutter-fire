import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
import 'package:get_flutter_fire/app/widgets/common/show_loader.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/app/widgets/profile/profile_list_widget.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';
import 'package:get_flutter_fire/theme/assets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    String getInitials(String name) {
      List<String> nameParts = name.split(' ');
      String initials = '';
      if (nameParts.isNotEmpty) {
        initials = nameParts.map((part) => part[0].toUpperCase()).join();
      }
      return initials;
    }

    final List<Map<String, dynamic>> profileItems = [
      {
        'imagePath': iconProfile,
        'text': 'Account Details',
        'onTap': () {
          Get.toNamed(Routes.ACCOUNT_DETAILS);
        }
      },
      {
        'imagePath': iconLocation,
        'text': 'Manage Address',
        'onTap': () {
          Get.toNamed(Routes.MANAGE_ADDRESS,
              arguments: {'user': authController.currentUser.value});
        }
      },
      {
        'imagePath': iconFile,
        'text': 'Terms and Conditions',
        'onTap': () {},
      },
      {
        'imagePath': iconFile,
        'text': 'Privacy Policy',
        'onTap': () {},
      },
      {
        'imagePath': iconSignout,
        'text': 'Sign Out',
        'onTap': () async {
          showLoader();
          authController.clearUserData();
          Get.offAllNamed(Routes.WELCOME);
          dismissLoader();
        },
      },
    ];

    return Scaffold(
      body: Column(
        children: [
          const Spacing(size: AppTheme.spacingMedium),
          Container(
            padding: AppTheme.paddingDefault,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.colorMain,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  width: 60,
                  height: 60,
                  child: Center(
                    child: Obx(() {
                      final user = authController.user;
                      return Text(
                        user != null ? getInitials(user.name) : 'JD',
                        style: AppTheme.fontStyleLarge
                            .copyWith(color: AppTheme.colorWhite),
                      );
                    }),
                  ),
                ),
                const Spacing(size: AppTheme.spacingSmall, isHorizontal: true),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      final user = authController.user;
                      return Text(
                        user?.name ?? 'Unknown User',
                        style: AppTheme.fontStyleMedium
                            .copyWith(color: AppTheme.colorMain),
                      );
                    }),
                    const SizedBox(height: AppTheme.spacingTiny),
                    Obx(() {
                      final user = authController.user;
                      return Text(
                        user?.phoneNumber ?? '+225 123 456 789',
                        style: AppTheme.fontStyleDefault
                            .copyWith(color: AppTheme.colorMain),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
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
                      itemCount: profileItems.length,
                      itemBuilder: (context, index) {
                        final item = profileItems[index];
                        return Column(
                          children: [
                            if (index == 0)
                              const Spacing(size: AppTheme.spacingTiny),
                            ProfileListItem(
                              imagePath: item['imagePath'],
                              text: item['text'],
                              onTap: item['onTap'],
                            ),
                          ],
                        );
                      },
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
