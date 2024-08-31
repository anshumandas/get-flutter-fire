import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streakzy/utils/constants/image_strings.dart';
import 'package:streakzy/utils/constants/sizes.dart';

import '../../modules/login/controllers/login_controller.dart';

/// A stateless widget that displays a row of social media buttons.
///
/// The buttons are typically used for social sign-ins like Google and Facebook.
class SSocialButton extends StatelessWidget {
  const SSocialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Container for the Google icon button.
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), // Adds a grey border around the button.
            borderRadius: BorderRadius.circular(100), // Makes the border circular.
          ),
          child: IconButton(
            onPressed: () => controller.googleSignIn(), // Placeholder for the Google sign-in action.
            icon: const Image(
              width: SSizes.iconMd, // Sets the width of the Google icon.
              height: SSizes.iconMd, // Sets the height of the Google icon.
              image: AssetImage(SImages.google), // Loads the Google icon image.
            ),
          ),
        ),

        // Adds space between the Google and Facebook buttons.
        const SizedBox(width: SSizes.spaceBtwItems),

        // Container for the Facebook icon button.
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), // Adds a grey border around the button.
            borderRadius: BorderRadius.circular(100), // Makes the border circular.
          ),
          child: IconButton(
            onPressed: (){}, // Placeholder for the Facebook sign-in action.
            icon: const Image(
              width: SSizes.iconMd, // Sets the width of the Facebook icon.
              height: SSizes.iconMd, // Sets the height of the Facebook icon.
              image: AssetImage(SImages.facebook), // Loads the Facebook icon image.
            ),
          ),
        ),
      ],
    );
  }
}
