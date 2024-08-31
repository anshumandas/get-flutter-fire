import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to the home screen after 3 seconds
    Future.delayed(Duration(seconds: 7), () {
      Get.offNamed(Routes.HOME); // Navigate to Home Screen
    });

    return Scaffold(
      backgroundColor: Colors.pinkAccent[50],
      body: Center(
        child: Image.asset('assets/icons/logo.png'), // Your splash logo
      ),
    );
  }
}
