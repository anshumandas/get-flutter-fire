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
                title: const Text('Select Theme'),
                subtitle: Text('Current theme: ${_getThemeName(controller.selectedThemeIndex.value)}'),
                trailing: DropdownButton<int>(
                  value: controller.selectedThemeIndex.value,
                  items: [
                    DropdownMenuItem(value: 0, child: Text('Classic Light')),
                    DropdownMenuItem(value: 1, child: Text('Midnight Dark')),
                    DropdownMenuItem(value: 2, child: Text('Mystic Purple')),
                    DropdownMenuItem(value: 3, child: Text('Emerald Delight')),
                    DropdownMenuItem(value: 4, child: Text('Cotton Candy')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectTheme(value);
                    }
                  },
                ),
              )),
        ],
      ),
    );
  }

  String _getThemeName(int index) {
    switch (index) {
      case 0:
        return 'Classic Light';
      case 1:
        return 'Midnight Dark';
      case 2:
        return 'Mystic Purple';
      case 3:
        return 'Emerald Delight';
      case 4:
        return 'Cotton Candy';
      default:
        return 'Unknown';
    }
  }
}
