import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get_flutter_fire/app/modules/persona/persona_controller.dart';

class SettingsController extends GetxController {
  final box = GetStorage();
  final selectedPersona = Rx<Persona?>(null);
  final isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  void loadSettings() {
    isDarkMode.value = box.read('isDarkMode') ?? false;
    int? savedPersonaIndex = box.read('personaIndex');
    if (savedPersonaIndex != null && savedPersonaIndex != -1) {
      selectedPersona.value = customPersonas[savedPersonaIndex];
    }
    updateTheme();
  }

  void setPersona(Persona? persona) {
    selectedPersona.value = persona;
    box.write('personaIndex', persona == null ? -1 : customPersonas.indexOf(persona));
    updateTheme();
  }

  void togglePersona(Persona persona) {
    if (selectedPersona.value?.name == persona.name) {
      setPersona(null);
    } else {
      setPersona(persona);
    }
  }

  void toggleDarkMode() {
    isDarkMode.toggle();
    box.write('isDarkMode', isDarkMode.value);
    updateTheme();
  }

  void updateTheme() {
    if (selectedPersona.value != null) {
      Persona persona = selectedPersona.value!;
      Get.changeTheme(ThemeData(
        primaryColor: persona.primaryColor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(persona.primaryColor.value, {
            50: persona.primaryColor.withOpacity(0.1),
            100: persona.primaryColor.withOpacity(0.2),
            200: persona.primaryColor.withOpacity(0.3),
            300: persona.primaryColor.withOpacity(0.4),
            400: persona.primaryColor.withOpacity(0.5),
            500: persona.primaryColor.withOpacity(0.6),
            600: persona.primaryColor.withOpacity(0.7),
            700: persona.primaryColor.withOpacity(0.8),
            800: persona.primaryColor.withOpacity(0.9),
            900: persona.primaryColor.withOpacity(1.0),
          }),
        ).copyWith(
          secondary: persona.secondaryColor,
        ),
        scaffoldBackgroundColor: persona.backgroundColor,
        textTheme: ThemeData.light().textTheme.apply(
          bodyColor: persona.textColor,
          displayColor: persona.textColor,
        ),
      ));
    } else {
      Get.changeTheme(isDarkMode.value ? ThemeData.dark() : ThemeData.light());
    }
  }
}