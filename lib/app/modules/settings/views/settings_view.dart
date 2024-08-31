import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/settings/controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = controller;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            title: Text('Dark Mode'),
            trailing: Obx(() {
              return Switch(
                value: settingsController.isDarkMode.value,
                onChanged: (value) {
                  settingsController.toggleDarkMode(value);
                },
              );
            }),
          ),
          // Add other settings options here
        ],
      ),
    );
  }
}
