import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:streakzy/utils/constants/sizes.dart';
import 'package:streakzy/utils/constants/text_strings.dart';
import '../../../widgets/login_form.dart';
import '../../../widgets/login_header.dart';
import '../../../widgets/login_signup/form_divider.dart';
import '../../../widgets/login_signup/social_buttons.dart';
import '../../../widgets/spacing_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final dark = SHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [

               const SLoginHeader(),
              //Form
              const SLoginForm(),

              //divider

              SFormDivider(dividerText: STexts.orSignInWith.capitalize!),

              const SizedBox(height: SSizes.spaceBtwSections),

              //footer
              const SSocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}








