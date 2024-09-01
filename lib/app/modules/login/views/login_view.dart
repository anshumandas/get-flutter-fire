import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../../../../models/screens.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed:
                  controller.isLoading.value ? null : () => controller.login(),
              child: Obx(() => controller.isLoading.value
                  ? CircularProgressIndicator()
                  : Text('Login')),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Get.toNamed('/reset-password'),
              child: Text('Forgot Password?'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => controller.googleSignIn(),
              child: const Text('Sign in with Google'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Get.rootDelegate.toNamed(Screen.REGISTER.route),
              child: const Text("Don't have an account? Sign up"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Get.toNamed('/email-link-auth'),
              child: Text('Sign in with Email Link'),
            ),
          ],
        ),
      ),
    );
  }
}
