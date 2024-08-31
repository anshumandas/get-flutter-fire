import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:streakzy/app/widgets/appbar/appbar.dart';
import 'package:streakzy/app/widgets/custom_shapes/containers/circular_container.dart';
import 'package:streakzy/app/widgets/texts/section_heading.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                const SCircularContainer(
                  image: SImages.user,
                  width: 80,
                  height: 80,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Change Profile Picture'),
                ),
                const SizedBox(height: SSizes.spaceBtwItems / 2),
                const Divider(),
                const SizedBox(height: SSizes.spaceBtwItems),
                const SSectionHeading(
                  title: 'Profile Information',
                  showActionButton: false,
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                SProfileMenu(onPressed: () {}, title: 'Name', value: 'Kenneth Rebello'),
                SProfileMenu(onPressed: () {}, title: 'Username', value: 'Kenneth31'),

                const SizedBox(height: SSizes.spaceBtwItems),
                const Divider(),
                const SizedBox(height: SSizes.spaceBtwItems),

                //heading
                const SSectionHeading(title: 'Personal Information', showActionButton: false),
                const SizedBox(height: SSizes.spaceBtwItems),

                SProfileMenu(onPressed: () {}, title: 'User Id', value: '31052002'),
                SProfileMenu(onPressed: () {}, title: 'Email', value: 'kenneth.rebello@mitwpu.edu.in'),
                SProfileMenu(onPressed: () {}, title: 'Phone Number', value: '+91 8317390275'),
                SProfileMenu(onPressed: () {}, title: 'Gender', value: 'Male'),
                SProfileMenu(onPressed: () {}, title: 'Date of Birth', value: '31 May 2002'),
                const Divider(),
                const SizedBox(height: SSizes.spaceBtwItems),
                
                Center(
                  child: TextButton(onPressed: (){},
                      child: const Text('Close Account', style: TextStyle(color: Colors.red)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

