import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final box = GetStorage();
  final RxBool isDarkMode = false.obs;
  final Rx<Persona?> selectedPersona = Rx<Persona?>(null);

  final Persona defaultLight = Persona(
    name: 'Classic Light',
    primaryColor: Colors.blue,
    secondaryColor: Colors.blueAccent,
    backgroundColor: Colors.white,
    textColor: Colors.black,
  );

  final List<Persona> personas = [
    Persona(
      name: 'Mystic Purple',
      primaryColor: Colors.deepPurple,
      secondaryColor: Colors.deepPurpleAccent,
      backgroundColor: Colors.deepPurple[50]!,
      textColor: Colors.deepPurple,
    ),
    Persona(
      name: 'Emerald Delight',
      primaryColor: Colors.teal,
      secondaryColor: Colors.tealAccent,
      backgroundColor: Colors.teal[50]!,
      textColor: Colors.teal,
    ),
    Persona(
      name: 'Cotton Candy',
      primaryColor: Colors.pink,
      secondaryColor: Colors.pinkAccent,
      backgroundColor: Colors.pink[50]!,
      textColor: Colors.pink,
    ),
    Persona(
      name: 'Ocean Breeze',
      primaryColor: Color(0xFF2196F3),
      secondaryColor: Color(0xFFBBDEFB),
      backgroundColor: Color(0xFFE3F2FD),
      textColor: Colors.black,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  void loadSettings() {
    try {
      isDarkMode.value = box.read('isDarkMode') ?? false;
      final savedPersonaIndex = box.read('selectedPersonaIndex') as int?;
      if (savedPersonaIndex != null && savedPersonaIndex < personas.length) {
        selectedPersona.value = personas[savedPersonaIndex];
      } else {
        selectedPersona.value = null;
      }
      print('Loaded settings: Dark Mode = ${isDarkMode.value}, Persona = ${selectedPersona.value?.name}');
    } catch (e) {
      print('Error loading settings: $e');
      isDarkMode.value = false;
      selectedPersona.value = null;
    }
    updateTheme();
  }

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    if (value) {
      selectedPersona.value = null; // Disable persona when dark mode is selected
    }
    box.write('isDarkMode', value);
    updateTheme();
  }

  void selectPersona(Persona persona) {
    selectedPersona.value = persona;
    isDarkMode.value = false; // Disable dark mode when persona is selected
    box.write('selectedPersonaIndex', personas.indexOf(persona));
    box.write('isDarkMode', false);
    updateTheme();
  }

  void updateTheme() {
    try {
      final themeData = isDarkMode.value
          ? ThemeData.dark()
          : selectedPersona.value != null
              ? ThemeData(
                  primaryColor: selectedPersona.value!.primaryColor,
                  scaffoldBackgroundColor: selectedPersona.value!.backgroundColor,
                  textTheme: TextTheme(
                    bodyLarge: TextStyle(color: selectedPersona.value!.textColor),
                    bodyMedium: TextStyle(color: selectedPersona.value!.textColor.withOpacity(0.7)),
                  ),
                  appBarTheme: AppBarTheme(
                    backgroundColor: selectedPersona.value!.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                )
              : ThemeData.light();

      Get.changeTheme(themeData);
    } catch (e) {
      print('Error updating theme: $e');
      Get.changeTheme(ThemeData.light()); // Fallback to light theme
    }
  }
}

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
