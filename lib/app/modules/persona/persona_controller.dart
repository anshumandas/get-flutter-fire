import 'package:flutter/material.dart';

class Persona {
  final String name;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color textColor;
  final List<Color> gradientColors;
  bool isDarkMode;

  Persona({
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.textColor,
    required this.gradientColors,
    this.isDarkMode = false,
  });

  Persona copyWith({bool? isDarkMode}) {
    return Persona(
      name: this.name,
      primaryColor: this.primaryColor,
      secondaryColor: this.secondaryColor,
      backgroundColor: isDarkMode ?? this.isDarkMode ? Colors.black : this.backgroundColor,
      textColor: isDarkMode ?? this.isDarkMode ? Colors.white : this.textColor,
      gradientColors: this.gradientColors,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}

final List<Persona> customPersonas = [
  Persona(
    name: 'Mars',
    primaryColor: Color(0xFFD32F2F), // Red
    secondaryColor: Color(0xFFB71C1C), // Dark Red
    backgroundColor: Color(0xFFFFCDD2), // Light Red
    textColor: Colors.white,
    gradientColors: [Color(0xFFD32F2F), Color(0xFFB71C1C), Color(0xFFFFCDD2)],
  ),
  Persona(
    name: 'Earth',
    primaryColor: Color(0xFF2196F3), // Blue
    secondaryColor: Color(0xFF64B5F6), // Light Blue
    backgroundColor: Color(0xFFE3F2FD), // Very Light Blue
    textColor: Colors.black,
    gradientColors: [Color(0xFF2196F3), Color(0xFF64B5F6), Color(0xFFE3F2FD)],
  ),
  Persona(
    name: 'Jupiter',
    primaryColor: Color(0xFFFF9800), // Orange
    secondaryColor: Color(0xFFFF5722), // Dark Orange
    backgroundColor: Color(0xFFFFF3E0), // Very Light Orange
    textColor: Colors.black,
    gradientColors: [Color(0xFFFF9800), Color(0xFFFF5722), Color(0xFFFFF3E0)],
  ),
  Persona(
    name: 'Neptune',
    primaryColor: Color(0xFF1E88E5), // Deep Blue
    secondaryColor: Color(0xFF1565C0), // Dark Blue
    backgroundColor: Color(0xFFBBDEFB), // Light Blue
    textColor: Colors.white,
    gradientColors: [Color(0xFF1E88E5), Color(0xFF1565C0), Color(0xFFBBDEFB)],
  ),
];
