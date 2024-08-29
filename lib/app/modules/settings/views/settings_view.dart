import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/services/theme_controller.dart'; // Import ThemeController
import '../controllers/settings_controller.dart'; // Import SettingsController

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure ThemeController is initialized
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Obx(
          () => SwitchListTile(
            title: const Text('Dark Mode'),
            value: themeController.isDarkMode.value,
            onChanged: (value) {
              controller
                  .toggleTheme(); // Call the method from SettingsController
            },
          ),
        ),
      ),
    );
  }
}
