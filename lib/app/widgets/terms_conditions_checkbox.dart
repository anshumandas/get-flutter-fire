import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streakzy/utils/constants/colors.dart';
import 'package:streakzy/utils/constants/sizes.dart';
import 'package:streakzy/utils/constants/text_strings.dart';
import 'package:streakzy/utils/helpers/helper_functions.dart';

import '../modules/signup/controllers/signup_controller.dart';

class STermsAndConditions extends StatelessWidget {
  const STermsAndConditions({
    super.key,
    // required this.dark,
  });

  // final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = SHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child:
          Obx(() =>
              Checkbox(value: controller.privacyPolicy.value,
                  onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value ))),
        const SizedBox(width: SSizes.spaceBtwItems),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${STexts.iAgreeTo} ',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall,
              ),
              TextSpan(
                text: '${STexts.privacyPolicy} ',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(
                  color: dark
                      ? SColors.white
                      : SColors.primary,
                  decorationColor: dark
                      ? SColors.white
                      : SColors.primary,
                ),
              ),
              TextSpan(
                text: '${STexts.and} ',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall,
              ),
              TextSpan(
                text: STexts.termsOfUse,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(
                  color: dark
                      ? SColors.white
                      : SColors.primary,
                  decorationColor: dark
                      ? SColors.white
                      : SColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}