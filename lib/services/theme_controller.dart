import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Persona {
  Modern(
    'Modern',
    ColorScheme(
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.teal,
      onSecondary: Colors.white,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Colors.grey,
      onSurface: Colors.black,
      brightness: Brightness.light,
      error: Colors.red,
      onError: Colors.white,
    ),
  ),
  Classical(
    'Classical',
    ColorScheme(
      primary: Colors.brown,
      onPrimary: Colors.white,
      secondary: Colors.orange,
      onSecondary: Colors.white,
      background: Colors.brown,
      onBackground: Colors.black,
      surface: Colors.brown,
      onSurface: Colors.black,
      brightness: Brightness.light,
      error: Colors.red,
      onError: Colors.white,
    ),
  ),
  French(
    'French',
    ColorScheme(
      primary: Colors.blue,
      onPrimary: Colors.black,
      secondary: Colors.pink,
      onSecondary: Colors.black,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Colors.blue,
      onSurface: Colors.black,
      brightness: Brightness.light,
      error: Colors.red,
      onError: Colors.black,
    ),
  ),
  British(
    'British',
    ColorScheme(
      primary: Colors.redAccent,
      onPrimary: Colors.white,
      secondary: Colors.blue,
      onSecondary: Colors.white,
      background: Colors.lightBlue,
      onBackground: Colors.white,
      surface: Colors.redAccent,
      onSurface: Colors.white,
      brightness: Brightness.dark,
      error: Colors.redAccent,
      onError: Colors.black,
    ),
  );

  final String name;
  final ColorScheme colorScheme;

  const Persona(this.name, this.colorScheme);
}

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  Rx<Persona> selectedPersona = Persona.French.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  void updatePersona(Persona persona) {
    selectedPersona.value = persona;
  }
}
