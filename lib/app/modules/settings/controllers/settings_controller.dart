import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final box = GetStorage();
  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  void loadSettings() {
    isDarkMode.value = box.read('isDarkMode') ?? false;
    updateTheme();
  }

  void toggleDarkMode() {
    isDarkMode.toggle();
    box.write('isDarkMode', isDarkMode.value);
    updateTheme();
  }

  void updateTheme() {
    Get.changeTheme(ThemeData(
      brightness: isDarkMode.value ? Brightness.dark : Brightness.light,
      primaryColor: isDarkMode.value ? Colors.grey[900] : Colors.blue,
      scaffoldBackgroundColor: isDarkMode.value ? Colors.black : Colors.white,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: isDarkMode.value ? Colors.white : Colors.black),
        bodyMedium: TextStyle(color: isDarkMode.value ? Colors.white70 : Colors.black54),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkMode.value ? Colors.grey[850] : Colors.blue,
        foregroundColor: isDarkMode.value ? Colors.white : Colors.black,
      ),
    ));
  }
}
