import 'dart:async';

import 'package:get/get.dart';

class DashboardController extends GetxController {
  final now = DateTime.now().obs;
  @override
  void onReady() {
    super.onReady();
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        now.value = DateTime.now();
      },
    );
  }
  var isSearchBarVisible = true.obs;
  void toggleSearchBarVisibility() {
    isSearchBarVisible.value = !isSearchBarVisible.value;
  }
  // Observable state for current time (example)
}
