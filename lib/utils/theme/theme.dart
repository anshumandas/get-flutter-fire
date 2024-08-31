import 'package:flutter/material.dart';
import 'package:streakzy/utils/theme/custom_themes/appbar_theme.dart';
import 'package:streakzy/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:streakzy/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:streakzy/utils/theme/custom_themes/chip_theme.dart';
import 'package:streakzy/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:streakzy/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:streakzy/utils/theme/custom_themes/text_field_theme.dart';
import 'package:streakzy/utils/theme/custom_themes/text_theme.dart';

class StreakzyTheme {
  StreakzyTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: STextTheme.lightTextTheme,
    elevatedButtonTheme: SElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: SAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: SBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: SCheckboxTheme.lightCheckboxTheme,
    chipTheme: SChipTheme.lightChipTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.lightOutlinedButtonTheme,
    // textTheme: STextTheme.lightTextTheme,
    // inputDecorationTheme: STextTheme.lightTextTheme,
    inputDecorationTheme: STextFormFieldTheme.lightInputDecorationTheme,

  );
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
      textTheme: STextTheme.darkTextTheme,
    elevatedButtonTheme: SElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: SAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: SBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: SCheckboxTheme.darkCheckboxTheme,
    chipTheme: SChipTheme.darkChipTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.lightOutlinedButtonTheme,
    // textTheme: STextTheme.lightTextTheme,
    inputDecorationTheme: STextFormFieldTheme.darkInputDecorationTheme,

  );
}