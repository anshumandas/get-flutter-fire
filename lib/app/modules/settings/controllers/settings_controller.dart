import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../persona/persona_controller.dart';

class SettingsController extends GetxController {
  final box = GetStorage();
  final Rx<Persona?> currentPersona = Rx<Persona?>(null);
  final RxBool isDarkMode = false.obs;

  Persona get activePersona => currentPersona.value ?? (isDarkMode.value ? defaultDark : defaultLight);

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  void loadSettings() {
    isDarkMode.value = box.read('isDarkMode') ?? false;
    int? savedPersonaIndex = box.read('personaIndex');
    if (savedPersonaIndex != null) {
      currentPersona.value = savedPersonaIndex == -1 ? null : customPersonas[savedPersonaIndex];
    }
    updateTheme();
  }

  void setPersona(Persona? persona) {
    currentPersona.value = persona;
    box.write('personaIndex', persona == null ? -1 : customPersonas.indexOf(persona));
    updateTheme();
  }

  void toggleDarkMode() {
    isDarkMode.toggle();
    box.write('isDarkMode', isDarkMode.value);
    if (currentPersona.value == null) {
      updateTheme();
    }
  }

  void updateTheme() {
    Get.changeTheme(ThemeData(
      primaryColor: activePersona.primaryColor,
      scaffoldBackgroundColor: activePersona.backgroundColor,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: activePersona.textColor),
        bodyMedium: TextStyle(color: activePersona.textColor),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: activePersona.primaryColor,
        foregroundColor: activePersona.textColor,
      ),
    ));
  }
}