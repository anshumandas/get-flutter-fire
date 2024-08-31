import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:streakzy/utils/constants/sizes.dart';
import 'package:streakzy/utils/constants/text_strings.dart';
import 'package:streakzy/utils/helpers/helper_functions.dart';
import '../../../widgets/login_signup/form_divider.dart';
import '../../../widgets/login_signup/social_buttons.dart';
import '../../../widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Text(STexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: SSizes.spaceBtwSections),

              //form
              const SSignupForm(),
              //divider

              const SizedBox(height: SSizes.spaceBtwSections),
              SFormDivider(dividerText: STexts.orSignUpWith.capitalize!),

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


