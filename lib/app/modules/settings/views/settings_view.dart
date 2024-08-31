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
        padding: const EdgeInsets.all(16),
        children: [
          Obx(() => SwitchListTile(
                title: const Text('Dark Mode'),
                value: controller.isDarkMode.value,
                onChanged: (value) {
                  controller.toggleDarkMode(value);
                },
              )),
          const SizedBox(height: 20),
          Text(
            'Select Persona',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => controller.selectPersona(controller.solitaireMale),
                child: Container(
                  width: 140,  // Adjusted width for a larger square
                  height: 140, // Adjusted height for a larger square
                  decoration: BoxDecoration(
                    color: controller.solitaireMale.backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          controller.solitaireMale.icon,
                          color: controller.solitaireMale.textColor,
                          size: 50,  // Adjusted icon size
                        ),
                        SizedBox(height: 10),
                        Text(
                          controller.solitaireMale.name,
                          style: TextStyle(
                            color: controller.solitaireMale.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (controller.selectedPersona.value == controller.solitaireMale)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Icon(Icons.check, color: controller.solitaireMale.primaryColor),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),  // Minimal spacing between boxes
              GestureDetector(
                onTap: () => controller.selectPersona(controller.solitaireFemale),
                child: Container(
                  width: 140,  // Adjusted width for a larger square
                  height: 140, // Adjusted height for a larger square
                  decoration: BoxDecoration(
                    color: controller.solitaireFemale.backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          controller.solitaireFemale.icon,
                          color: controller.solitaireFemale.textColor,
                          size: 50,  // Adjusted icon size
                        ),
                        SizedBox(height: 10),
                        Text(
                          controller.solitaireFemale.name,
                          style: TextStyle(
                            color: controller.solitaireFemale.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (controller.selectedPersona.value == controller.solitaireFemale)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Icon(Icons.check, color: controller.solitaireFemale.primaryColor),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
