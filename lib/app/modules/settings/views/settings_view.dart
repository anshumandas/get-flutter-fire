import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/settings/controllers/settings_controller.dart';
import 'package:get_flutter_fire/models/screens.dart';

import '../../../routes/app_pages.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Obx(() => ListTile(
            title: Text('Dark Mode'),
            subtitle: Text(controller.currentPersona.value == null ? 'Applies to default theme' : 'Disabled when using a persona'),
            trailing: Switch(
              value: controller.isDarkMode.value,
              onChanged: controller.currentPersona.value == null
                  ? (value) => controller.toggleDarkMode()
                  : null,
            ),
          )),
        ],
      ),
    );
  }
}