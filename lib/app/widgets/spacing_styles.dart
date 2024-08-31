import 'package:flutter/material.dart';
import 'package:streakzy/utils/constants/sizes.dart';

/// A utility class that provides consistent spacing and padding styles
/// for use throughout the app.
///
/// This class is particularly useful for maintaining consistent spacing
/// in different parts of the app, such as around the app bar or between
/// UI elements.
class SSpacingStyle {
  /// Provides padding that accounts for the height of the app bar at the top,
  /// along with default spacing on the left, right, and bottom.
  ///
  /// This padding is typically used to ensure that content is spaced
  /// correctly from the edges of the screen, considering the app bar's height.
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: SSizes.appBarHeight, // Top padding equal to the app bar height.
    left: SSizes.defaultSpace, // Left padding with default spacing.
    bottom: SSizes.defaultSpace, // Bottom padding with default spacing.
    right: SSizes.defaultSpace, // Right padding with default spacing.
  );
}
