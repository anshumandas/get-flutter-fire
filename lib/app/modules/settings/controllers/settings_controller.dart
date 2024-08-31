import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final GetStorage _storage = GetStorage();
  final RxBool _isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _isDarkMode.value = _storage.read('darkMode') ?? false;
  }

  RxBool get isDarkMode => _isDarkMode;

  void toggleDarkMode(bool value) {
    _isDarkMode.value = value;
    _storage.write('darkMode', value);
    // Notify app of theme change
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }
}
