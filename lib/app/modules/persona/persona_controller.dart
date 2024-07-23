import 'package:flutter/material.dart';

class Persona {
  final String name;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color textColor;

  Persona({
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.textColor,
  });
}

final Persona defaultLight = Persona(
  name: 'Default Light',
  primaryColor: Color(0xFF6F35A5),
  secondaryColor: Color(0xFFF1E6FF),
  backgroundColor: Colors.white,
  textColor: Colors.black,
);

final Persona defaultDark = Persona(
  name: 'Default Dark',
  primaryColor: Color(0xFF9C27B0),
  secondaryColor: Color(0xFF4A148C),
  backgroundColor: Color(0xFF121212),
  textColor: Colors.white,
);

final List<Persona> customPersonas = [
  Persona(
    name: 'Ocean',
    primaryColor: Color(0xFF1976D2),
    secondaryColor: Color(0xFF64B5F6),
    backgroundColor: Color(0xFFE3F2FD),
    textColor: Colors.black,
  ),
  Persona(
    name: 'Forest',
    primaryColor: Color(0xFF388E3C),
    secondaryColor: Color(0xFF81C784),
    backgroundColor: Color(0xFFE8F5E9),
    textColor: Colors.black,
  ),
  Persona(
    name: 'Sunset',
    primaryColor: Color(0xFFFF7043),
    secondaryColor: Color(0xFFFFAB91),
    backgroundColor: Color(0xFFFFF3E0),
    textColor: Colors.black,
  ),
  Persona(
    name: 'Lavender',
    primaryColor: Color(0xFF7E57C2),
    secondaryColor: Color(0xFFB39DDB),
    backgroundColor: Color(0xFFEDE7F6),
    textColor: Colors.black,
  ),
];