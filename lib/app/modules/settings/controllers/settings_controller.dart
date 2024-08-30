import 'package:get/get.dart';
import '/services/theme_controller.dart';

class SettingsController extends GetxController {
  final ThemeController themeController = Get.find<ThemeController>();

  // Rx variable to track selected persona
  var selectedPersona = Persona.French.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with the current theme's persona
    selectedPersona.value = themeController.selectedPersona.value;
  }

  // Method to toggle between dark and light theme
  void toggleTheme() {
    themeController.toggleTheme();
  }

  // Method to update persona selection
  void updatePersona(Persona persona) {
    selectedPersona.value = persona;
    themeController.updatePersona(persona);
  }
}
