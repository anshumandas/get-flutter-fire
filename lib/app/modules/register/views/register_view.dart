import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../services/auth_service.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.email,
                size: 80,
                color: Colors.orange,
              ),
              const SizedBox(height: 20),
              const Text(
                'Please verify your email (check SPAM folder), and then relogin',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => AuthService.to.register(),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text("Verification Done. Relogin"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _signInWithGoogle(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Google Sign-In button color
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/google_logo.png', width: 24),
                    const SizedBox(width: 8),
                    const Text("Sign in with Google"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signInWithGoogle() async {
    try {
      await AuthService.to.signInWithGoogle();
    } catch (e) {
      // Handle errors appropriately, e.g., show an error message
      Get.snackbar('Sign-In Error', e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
