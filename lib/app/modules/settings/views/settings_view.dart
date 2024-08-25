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
          // Wrap GridView in a Container to provide additional padding if needed
          Container(
            padding: const EdgeInsets.only(bottom: 16), // Extra padding to prevent overflow
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5, // Adjusted aspect ratio
              ),
              itemCount: controller.personas.length,
              itemBuilder: (context, index) {
                final persona = controller.personas[index];
                final isSelected = controller.selectedPersona.value == persona;

                return GestureDetector(
                  onTap: () => controller.selectPersona(persona),
                  child: Card(
                    color: persona.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.color_lens,
                                color: persona.primaryColor,
                                size: 36, // Slightly reduced icon size
                              ),
                              const SizedBox(height: 8),
                              Text(
                                persona.name,
                                style: TextStyle(
                                  color: persona.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12, // Slightly reduced font size
                                ),
                                textAlign: TextAlign.center, // Center text to fit well
                              ),
                              const SizedBox(height: 8), // Adjusted spacing
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 8, // Adjusted bottom position to prevent overlap
                          left: 0,
                          right: 0,
                          child: Center(
                            child: isSelected
                                ? Icon(
                                    Icons.circle,
                                    color: persona.primaryColor,
                                    size: 12, // Adjusted dot size
                                  )
                                : Container(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
