import 'dart:async';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Existing properties
  final now = DateTime.now().obs;
  final List<String> items = List<String>.generate(10, (i) => 'Item $i');

  // New property to track the carousel index
  final carouselIndex = 0.obs;

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
