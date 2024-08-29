import 'package:get/get.dart';
import '/services/theme_controller.dart';

class SettingsController extends GetxController {
  final ThemeController themeController = Get.find<ThemeController>();

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;

  void toggleTheme() {
    themeController.toggleTheme();
  }
}
