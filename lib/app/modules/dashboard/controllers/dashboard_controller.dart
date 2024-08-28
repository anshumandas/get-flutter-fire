import 'dart:async';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Existing properties
  final now = DateTime.now().obs;
  final List<String> items = [
    'assets/images/shoes.jpg',
    'assets/images/fire1.png',
    'assets/images/flutterfire_300x.png',
  ];

  // New property to track the carousel index
  final carouselIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    // API Call to receive data regarding these clothes

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // Update the time every second
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        now.value = DateTime.now();
      },
    );
  }

  // New method to update the carousel index
  void updateCarouselIndex(int index) {
    carouselIndex.value = index;
  }
}
