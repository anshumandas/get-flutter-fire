import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:streakzy/utils/constants/colors.dart';
import 'package:streakzy/utils/constants/sizes.dart';
import 'package:streakzy/utils/device/device_utility.dart';
import 'package:streakzy/utils/helpers/helper_functions.dart';

import '../modules/onboarding/controllers/onboarding_controller.dart';
class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Positioned(
        right: SSizes.defaultSpace,
        bottom: SDeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(
          onPressed: () => OnBoardingController.instance.nextPage(),
          style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: dark ? SColors.primary: Colors.black),
          child: const Icon(Iconsax.arrow_right_3),
        )

    );
  }
}