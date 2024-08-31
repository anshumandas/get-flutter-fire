import 'package:flutter/material.dart';

class SColors{
  SColors._(); // To keep our constructor private

  static const Color primary = Color(0xFF4864FF);
  static const Color secondary = Color(0xFFFFE248);
  static const Color accent = Color(0xFFb0c7ff);

  //Text

  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C7570);
  static const Color textWhite = Colors.white;

  //Background
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  // Background Container Color
  static const Color lightContainer = Color(0xFFF6F6F6);
  static const Color darkContainer = Color(0x8E8686FF);

  //Gradient Colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xffff9a9e),
      Color(0xfffad0c4),
      Color(0xfffad0c4),
    ],
  );

  //Button Colors

  static const Color buttonPrimary = Color(0xFF4b68ff);
  static const Color buttonSecondary = Color(0xFF6C7570);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  //Border Colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  // Error and validation Colors
static const Color error = Color(0xFFD32F2F);
static const Color success = Color(0xFF388E3C);
static const Color warning = Color(0xFFF57C00);
static const Color info = Color(0xFF197602);

//Neural
static const Color black = Color(0xFF232323);
static const Color darkerGrey = Color(0xFF4F4F4F);
static const Color darkGrey = Color(0xFF939393);
static const Color grey = Color(0xFFE0E0E0);
static const Color softGrey = Color(0xFFF4F4F4);
static const Color lightGrey = Color(0xFFF9F9F9);
static const Color white = Color(0xFFFFFFFF);
}