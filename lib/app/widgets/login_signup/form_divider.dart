import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:streakzy/utils/constants/colors.dart';
import 'package:streakzy/utils/constants/text_strings.dart';
import 'package:streakzy/utils/helpers/helper_functions.dart';

/// A custom widget that displays a divider with text in the middle, often used in forms to separate sections.
class SFormDivider extends StatelessWidget {
  /// Constructor for the `SFormDivider`.
  ///
  /// [dividerText] is the text to display in the middle of the divider.
  const SFormDivider({
    super.key,
    required this.dividerText,
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    // Determines if the app is in dark mode using a helper function.
    final dark = SHelperFunctions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // A flexible divider line on the left side of the text.
        Flexible(
          child: Divider(
            color: dark ? SColors.darkerGrey : SColors.grey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),

        // The text displayed in the middle of the divider.
        Text(
          STexts.orSignInWith.capitalize!, // Capitalizes the first letter of the text.
          style: Theme.of(context).textTheme.labelMedium,
        ),

        // A flexible divider line on the right side of the text.
        Flexible(
          child: Divider(
            color: dark ? SColors.darkerGrey : SColors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
