// ignore_for_file: inference_failure_on_function_invocation

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../firebase_options.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => loginScreen());
  }

  Widget headerBuilder(context, constraints, shrinkOffset) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset('assets/images/flutterfire_300x.png'),
      ),
    );
  }

  Widget subtitleBuilder(context, action) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: action == AuthAction.signIn
          ? const Text('Welcome to Get Flutter Fire, please sign in!')
          : const Text('New to Get Flutter Fire, please sign up!'),
    );
  }

  Widget footerBuilder(context, action) {
    return const Padding(
      padding: EdgeInsets.only(top: 16),
      child: Text(
        'By signing in, you agree to our terms and conditions.',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget sideBuilder(context, shrinkOffset) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset('assets/images/flutterfire_300x.png'),
      ),
    );
  }

  Widget loginScreen() {
    if (!controller.isLoggedIn) {
      return !(GetPlatform.isAndroid || GetPlatform.isIOS) && controller.isRobot
          ? recaptcha()
          : SignInScreen(
              providers: [
                EmailAuthProvider(),
                GoogleProvider(clientId: DefaultFirebaseOptions.webClientId),
              ],
              showPasswordVisibilityToggle: true,
              headerBuilder: headerBuilder,
              subtitleBuilder: subtitleBuilder,
              footerBuilder: footerBuilder,
              sideBuilder: sideBuilder,
            );
    } else if (controller.isAnon) {
      return RegisterScreen(
        showAuthActionSwitch: !controller.isAnon, //if Anon only SignUp
        showPasswordVisibilityToggle: true,
        headerBuilder: headerBuilder,
        subtitleBuilder: subtitleBuilder,
        footerBuilder: footerBuilder,
        sideBuilder: sideBuilder,
      );
    }
    final thenTo =
        Get.rootDelegate.currentConfiguration!.currentPage!.parameters?['then'];
    Get.rootDelegate.offNamed(thenTo ?? Routes.HOME);
    return const Scaffold();
  }

  Widget recaptcha() {
    //TODO: Add Recaptcha
    return Scaffold(
        body: TextButton(
      onPressed: () => controller.robot = false,
      child: const Text("Are you a Robot?"),
    ));
  }
}
