import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    super.onInit();
    // Initialize any necessary data or services here
  }

  Future<RootController> init() async {
    // Perform any initialization here
    await Future.delayed(Duration.zero); // Example delay, remove if not needed
    return this;
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState?.closeDrawer();
  }
}
