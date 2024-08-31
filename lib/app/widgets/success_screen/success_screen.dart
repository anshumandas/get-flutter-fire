import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streakzy/utils/constants/image_strings.dart';
import 'package:streakzy/utils/constants/sizes.dart';
import 'package:streakzy/utils/constants/text_strings.dart';
import 'package:streakzy/utils/helpers/helper_functions.dart';

import '../spacing_styles.dart';

/// A stateless widget that displays a success screen with an image, title, subtitle, and a button.
///
/// The screen is typically used to show a success message after completing an action.
class SuccessScreen extends StatelessWidget {
  /// Constructor for the `SuccessScreen`.
  ///
  /// [image] is the path to the image displayed at the top.
  /// [title] is the main title text.
  /// [subTitle] is the subtitle text.
  /// [onPressed] is the callback function executed when the button is pressed.
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SSpacingStyle.paddingWithAppBarHeight * 2, // Adds padding around the content.
          child: Column(
            children: [
              // Image at the top of the screen.
              Image(
                image: AssetImage(image), // Loads the image from the asset path.
                width: SHelperFunctions.screenWidth() * 0.6, // Sets the width to 60% of the screen width.
              ),
              const SizedBox(height: SSizes.spaceBtwSections), // Space between the image and the title.

              // Title text
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium, // Applies headlineMedium text style from the theme.
                textAlign: TextAlign.center, // Centers the text.
              ),
              const SizedBox(height: SSizes.spaceBtwItems), // Space between the title and the subtitle.

              // Subtitle text
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium, // Applies labelMedium text style from the theme.
                textAlign: TextAlign.center, // Centers the text.
              ),
              const SizedBox(height: SSizes.spaceBtwItems), // Space between the subtitle and the button.

              // Button at the bottom of the screen.
              SizedBox(
                width: double.infinity, // Makes the button full-width.
                child: ElevatedButton(
                  onPressed: onPressed, // Executes the onPressed callback when the button is pressed.
                  child: const Text(STexts.tContinue), // Button text.
                ),
              ),
              const SizedBox(height: SSizes.spaceBtwItems), // Space at the bottom of the screen.
            ],
          ),
        ),
      ),
    );
  }
}
