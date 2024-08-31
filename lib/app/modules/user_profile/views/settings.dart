import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:streakzy/app/modules/user_profile/views/profile.dart';
import 'package:streakzy/utils/constants/colors.dart';
import 'package:streakzy/utils/constants/sizes.dart';
import '../../../widgets/appbar/appbar.dart';
import '../../../widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../widgets/list_tile/settings_menu_tile.dart';
import '../../../widgets/list_tile/user_profile_tile.dart';
import '../../../widgets/texts/section_heading.dart';
import '../../login/bindings/login.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///header
            SPrimaryHeaderContainer(
              child: Column(
                children: [
                  ///APPBar
                  SAppBar(
                      title: Text('Account',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .apply(color: SColors.white))),
                  // const SizedBox(height: SSizes.spaceBtwSections),

                  //userprofile
                  TUserProfileTile(onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(height: SSizes.spaceBtwSections),
                ],
              ),
            ),

            ///body

            Padding(
              padding: const EdgeInsets.all(SSizes.defaultSpace),
              child: Column(
                children: [
                  //Account settings
                  const SSectionHeading(
                      title: 'Account Settings', showActionButton: false),
                  const SizedBox(height: SSizes.spaceBtwItems),

                  SSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subTitle: 'Set up Shopping and Delivery Address',
                    onTap: () {},
                  ),

                  //2
                  SSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My cart',
                    subTitle: 'Add or remove from cart',
                    onTap: (){},
                  ),

                  //3
                  SSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'Check out your orders',
                    onTap: (){},
                  ),

                  //4
                  SSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subTitle: 'For ease in refund',
                    onTap: (){},
                  ),

                  //5
                  SSettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subTitle: 'List of all discount coupons',
                    onTap: (){},
                  ),

                  //6
                  SSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subTitle: 'Set Notifications',
                    onTap: (){},
                  ),

                  //7
                  SSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subTitle: 'Manage data and usage',
                    onTap: (){},
                  ),

                  //App Settings

                  const SizedBox(height: SSizes.spaceBtwSections),
                  const SSectionHeading(title: 'App Settings', showActionButton: false),
                  const SizedBox(height: SSizes.spaceBtwItems),
                  const SSettingsMenuTile(icon: Iconsax.document_upload, title: 'Load Data', subTitle: 'Upload data to your cloud firebase'),
                  //1
                  SSettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                    onTap: (){},
                  ),

                  //2
                  SSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                    onTap: (){},
                  ),

                  //3
                  SSettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set Image quality',
                    trailing: Switch(value: false, onChanged: (value) {}),
                    onTap: (){},
                  ),

                  //Logout Button
                  const SizedBox(height: SSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => const LoginScreen()),
                          child: const Text('Logout')),
                  ),
                  const SizedBox(height: SSizes.spaceBtwSections * 2.5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
