import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final box = GetStorage();
  final RxInt selectedThemeIndex = 0.obs;

  final List<ThemeData> themes = [
    ThemeData.light(), // Light Theme
    ThemeData.dark(),  // Dark Theme
    ThemeData(        // Midnight Theme
      brightness: Brightness.light,
      primaryColor: Colors.deepPurple,
      scaffoldBackgroundColor: Colors.deepPurple[50],
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.deepPurple),
        bodyMedium: TextStyle(color: Colors.deepPurpleAccent),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
    ),
    ThemeData(        // Emerald Theme
      brightness: Brightness.light,
      primaryColor: Colors.teal,
      scaffoldBackgroundColor: Colors.teal[50],
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.teal),
        bodyMedium: TextStyle(color: Colors.tealAccent),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
    ),
    ThemeData(        // Pink Theme (Cotton Candy)
      brightness: Brightness.light,
      primaryColor: Colors.pink,
      scaffoldBackgroundColor: Colors.pink[50],
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.pink),
        bodyMedium: TextStyle(color: Colors.pinkAccent),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  void loadSettings() {
    selectedThemeIndex.value = box.read('selectedThemeIndex') ?? 0;
    updateTheme();
  }

  void selectTheme(int index) {
    selectedThemeIndex.value = index;
    box.write('selectedThemeIndex', index);
    updateTheme();
  }

  void updateTheme() {
    Get.changeTheme(themes[selectedThemeIndex.value]);
  }
}
