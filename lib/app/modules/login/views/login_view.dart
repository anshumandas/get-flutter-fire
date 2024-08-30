import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/my_button.dart';
import '../../../widgets/my_text_field.dart';
import '../controllers/login_controller.dart';


class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Image(
                    image: AssetImage('lib/images/eduryde_circular.png'),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: Get.find<LoginController>().emailController,
                  hintText: 'Email',
                ),
                MyTextField(
                  controller: Get.find<LoginController>().passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                MyButton(
                  text: 'Login',
                  onTap: () => Get.find<LoginController>().login(),
                ),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                  child: Text('Forgot Password?'),
                ),
                TextButton(
                  onPressed: () => Get.find<LoginController>().goToRegister(),
                  child: Text('Don\'t have an account? Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
