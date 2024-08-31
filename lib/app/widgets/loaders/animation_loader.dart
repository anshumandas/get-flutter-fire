import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:streakzy/utils/constants/colors.dart';
import 'package:streakzy/utils/constants/sizes.dart';

/// A stateless widget that displays an animation loader with optional text and an action button.
class SAnimationLoaderWidget extends StatelessWidget {

  /// Constructor for `SAnimationLoaderWidget`.
  ///
  /// [text] is the message to display under the animation.
  /// [animation] is the path to the Lottie animation file.
  /// [showAction] determines if the action button is shown.
  /// [actionText] is the text displayed on the action button (required if [showAction] is true).
  /// [onActionPressed] is the callback executed when the action button is pressed.
  const SAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Displays the Lottie animation with a width that is 80% of the screen width.
          Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.8),

          // Adds some vertical spacing between the animation and the text.
          const SizedBox(height: SSizes.defaultSpace),

          // Displays the provided text, styled according to the app's theme.
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),

          // Adds some vertical spacing between the text and the action button.
          const SizedBox(height: SSizes.defaultSpace),

          // Conditionally displays the action button if [showAction] is true.
          showAction
              ? SizedBox(
            width: 250,
            child: OutlinedButton(
              onPressed: onActionPressed,
              style: OutlinedButton.styleFrom(backgroundColor: SColors.dark),
              child: Text(
                actionText!,
                style: Theme.of(context).textTheme.bodyMedium!.apply(color: SColors.light),
              ),
            ),
          )
              : const SizedBox(), // Displays an empty box if no action button is needed.
        ],
      ),
    );
  }
}
