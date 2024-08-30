import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/services/theme_controller.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Toggle Theme Button
            Obx(
              () => SwitchListTile(
                title: const Text('Dark Mode'),
                value: themeController.isDarkMode.value,
                onChanged: (value) {
                  controller.toggleTheme();
                },
              ),
            ),
            const SizedBox(height: 20),
            // Persona Selection Cards
            Text(
              'Select Persona:',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),
            // Centering and spacing cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: Persona.values.map((persona) {
                    return GestureDetector(
                      onTap: () => controller.updatePersona(persona),
                      child: Obx(
                        () => Container(
                          width: 150, // Increased width for better appearance
                          height: 200, // Increased height for better appearance
                          decoration: BoxDecoration(
                            gradient:
                                themeController.selectedPersona.value == persona
                                    ? LinearGradient(
                                        colors: [
                                          persona.colorScheme.primary
                                              .withOpacity(0.8),
                                          persona.colorScheme.secondary
                                              .withOpacity(0.8),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                    : LinearGradient(
                                        colors: [
                                          persona.colorScheme.primary
                                              .withOpacity(0.5),
                                          persona.colorScheme.secondary
                                              .withOpacity(0.5),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            border: Border.all(
                              color: themeController.selectedPersona.value ==
                                      persona
                                  ? Colors.white
                                  : Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                size: 50, // Increased icon size
                                color: persona.colorScheme.onPrimary,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                persona.name,
                                style: TextStyle(
                                  fontSize: 18, // Increased font size for title
                                  fontWeight: FontWeight.bold,
                                  color: persona.colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
