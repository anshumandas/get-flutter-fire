import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/settings/controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          Obx(() => ListTile(
            title: const Text('Dark Mode'),
            subtitle: Text(controller.isDarkMode.value ? 'Dark mode is enabled' : 'Dark mode is disabled'),
            trailing: Switch(
              value: controller.isDarkMode.value,
              onChanged: (value) => controller.toggleDarkMode(),
            ),
          )),
        ],
      ),
    );
  }
}
