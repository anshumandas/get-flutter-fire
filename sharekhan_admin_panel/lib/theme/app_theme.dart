import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color colorBlack = Color(0xff040520);
  static const Color colorWhite = Colors.white;
  static const Color greyTextColor = Color(0xffA7A7AF);
  static const Color colorRed = Color(0xffAC1E2F);
  static const Color colorGrey = Color(0xff8A8A8A);
  static const Color colorDisabled = Color(0xFFCFCFCF);
  static const Color backgroundColor = Color(0xffF2F2F3);
  static const Color borderColor = Color(0xffDCDCE0);

  //Font Size
  static const double fontSizeSmall = 12.0;
  static const double fontSizeDefault = 14.0;
  static const double fontSizeMedium = 16.0;
  static const double fontSizeLarge = 24.0;

  //Spacing
  static const double spacingTiny = 8.0;
  static const double spacingExtraSmall = 12.0;
  static const double spacingSmall = 16.0;
  static const double spacingSemiMedium = 20.0;
  static const double spacingDefault = 24.0;
  static const double spacingMedium = 32.0;
  static const double spacingLarge = 40.0;
  static const double spacingExtraLarge = 48.0;

  // Font Styles

  static const TextStyle fontStyleSmall = TextStyle(
    fontFamily: 'Nunito',
    fontSize: fontSizeSmall,
    fontWeight: FontWeight.w400,
    color: colorBlack,
  );

  static const TextStyle fontStyleDefault = TextStyle(
    fontFamily: 'Nunito',
    fontSize: fontSizeDefault,
    fontWeight: FontWeight.w400,
    color: colorBlack,
  );

  static const TextStyle fontStyleDefaultBold = TextStyle(
    fontFamily: 'Nunito',
    fontSize: fontSizeDefault,
    fontWeight: FontWeight.bold,
    color: colorBlack,
  );

  static const TextStyle fontStyleMedium = TextStyle(
    fontFamily: 'Nunito',
    fontSize: fontSizeMedium,
    fontWeight: FontWeight.w400,
    color: colorBlack,
  );

  static const TextStyle fontStyleHeadingDefault = TextStyle(
    fontFamily: 'PT Serif',
    fontSize: fontSizeDefault,
    fontWeight: FontWeight.w400,
    color: colorBlack,
  );

  static const TextStyle fontStyleHeadingMedium = TextStyle(
    fontFamily: 'PT Serif',
    fontSize: fontSizeMedium,
    fontWeight: FontWeight.w400,
    color: colorBlack,
  );

  static const TextStyle fontStyleLarge = TextStyle(
    fontFamily: 'PT Serif',
    fontSize: fontSizeLarge,
    fontWeight: FontWeight.w400,
    color: colorRed,
  );

  // Padding
  static const EdgeInsets paddingDefault = EdgeInsets.all(spacingDefault);
  static const EdgeInsets paddingSmall = EdgeInsets.all(spacingSmall);
  static const EdgeInsets paddingTiny = EdgeInsets.all(spacingTiny);
  static const EdgeInsets paddingBottom =
      EdgeInsets.only(bottom: spacingDefault);
  static const EdgeInsets paddingSymetricHorizontal =
      EdgeInsets.symmetric(horizontal: spacingDefault);
  static const EdgeInsets paddingSymetricVertical =
      EdgeInsets.symmetric(vertical: spacingDefault);

  // Border Radius
  static BorderRadius borderRadiusSmall = BorderRadius.circular(4);
  static BorderRadius borderRadius = BorderRadius.circular(8);

  // Shapes
  static ShapeBorder rrShapeSmall = RoundedRectangleBorder(
    borderRadius: borderRadiusSmall,
  );

  static ShapeBorder rrShape = RoundedRectangleBorder(
    borderRadius: borderRadius,
  );

  // Borders
  static Border cardBorder = Border.all(color: borderColor, width: 1);
  static OutlineInputBorder textfieldBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: borderColor, width: 1),
    borderRadius: borderRadius,
  );

  static const UnderlineInputBorder textfieldUnderlineBorder =
      UnderlineInputBorder(
    borderSide: BorderSide(color: borderColor, width: 1),
  );

  // Decorations
  static BoxDecoration cardDecoration = BoxDecoration(
      borderRadius: borderRadius, border: cardBorder, color: colorWhite);
}
