// lib/app/modules/home/controllers/home_controller.dart
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Example observable variable
  RxString userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize your data or state here
    userName.value = 'User'; // Set a default value or fetch user info
  }

// Add more methods or functionality here if needed
}
