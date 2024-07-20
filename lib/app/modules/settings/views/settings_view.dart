import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../services/persona_service.dart';
import '../../persona_selection_screen.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final personaService = Get.find<PersonaService>();

    return Scaffold(
      body: ListView(
        children: [
          Obx(() {
            bool isDarkMode = personaService.themeMode == ThemeMode.dark;
            return ListTile(
              title: Text('Dark Mode'),
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  personaService.toggleDarkMode(value);
                },
              ),
            );
          }),
          ListTile(
            title: Text('Select Persona'),
            onTap: () {
              Get.to(() => PersonaSelectionScreen());
            },
          ),
        ],
      ),
    );
  }
}
