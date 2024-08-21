import 'dart:async'; // Import this for Timer
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/widgets/login_widgets.dart';
import '../../../../services/auth_service.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    // Timer to check email verification status
    Timer? timer;

    // Function to check email verification status
    void checkEmailVerification() async {
      final user = AuthService.to.user;
      if (user != null) {
        await user.reload(); // Reload user to get the latest data
        if (user.emailVerified) {
          AuthService.to.register(); // Navigate away once email is verified
          timer?.cancel(); // Stop the timer
        }
      }
    }

    // Start a timer to periodically check email verification status
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerification();
    });

    // Display the EmailVerificationScreen initially
    var w = EmailVerificationScreen(
      headerBuilder: LoginWidgets.headerBuilder,
      sideBuilder: LoginWidgets.sideBuilder,
      actions: [
        EmailVerifiedAction(() {
          // You might want to handle verification done action here, but
          // navigation should be handled automatically by the timer.
        }),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true,
      ),
      body: Center(
        child: w,
      ),
    );
  }
}
