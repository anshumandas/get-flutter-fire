import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final GetStorage box = GetStorage();
  final RxBool isDarkMode = false.obs;
  final Rx<Persona?> selectedPersona = Rx<Persona?>(null);

  final Persona solitaireMale = Persona(
    name: 'Solitaire Male',
    primaryColor: Colors.blue,
    secondaryColor: Colors.blueAccent,
    backgroundColor: Colors.blue[50]!,
    textColor: Colors.blue,
    icon: Icons.male,
  );

  final Persona solitaireFemale = Persona(
    name: 'Solitaire Female',
    primaryColor: Colors.pink,
    secondaryColor: Colors.pinkAccent,
    backgroundColor: Colors.pink[50]!,
    textColor: Colors.pink,
    icon: Icons.female,
  );

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  void loadSettings() {
    try {
      isDarkMode.value = box.read('isDarkMode') ?? false;
      final savedPersonaName = box.read('selectedPersona');
      selectedPersona.value = savedPersonaName == 'Solitaire Male'
          ? solitaireMale
          : savedPersonaName == 'Solitaire Female'
              ? solitaireFemale
              : null;
      updateTheme();
    } catch (e) {
      print('Error loading settings: $e');
      isDarkMode.value = false;
      selectedPersona.value = null;
    }
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
    box.write('selectedPersona', persona.name);
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
              : ThemeData(
                  primaryColor: const Color(0xFF5D3A69),  // Rich Plum
                  scaffoldBackgroundColor: const Color(0xFFF5F5DC),  // Soft Cream
                  hintColor: const Color(0xFFD4AF37),  // Antique Gold
                  textTheme: const TextTheme(
                    bodyLarge: TextStyle(color: Color(0xFF333333)),  // Charcoal Gray
                    bodyMedium: TextStyle(color: Color.fromARGB(255, 63, 59, 59)),

                  ),
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Color(0xFF5D3A69),  // Rich Plum
                    foregroundColor: Colors.white,
                  ),
                );

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
  final IconData icon;  // Icon for the persona

  Persona({
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
  });
}
