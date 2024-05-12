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

  Widget loginScreen() {
    if (!controller.isLoggedIn) {
      return SignInScreen(
        providers: [
          EmailAuthProvider(),
          GoogleProvider(clientId: DefaultFirebaseOptions.webClientId),
        ],
        headerBuilder: (context, constraints, shrinkOffset) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset('flutterfire_300x.png'),
            ),
          );
        },
        subtitleBuilder: (context, action) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: action == AuthAction.signIn
                ? const Text('Welcome to Get Flutter Fire, please sign in!')
                : const Text('New to Get Flutter Fire, please sign up!'),
          );
        },
        footerBuilder: (context, action) {
          return const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'By signing in, you agree to our terms and conditions.',
              style: TextStyle(color: Colors.grey),
            ),
          );
        },
        sideBuilder: (context, shrinkOffset) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset('flutterfire_300x.png'),
            ),
          );
        },
      );
    } else if (controller.isAnon) {
      return RegisterScreen(
        showAuthActionSwitch: !controller.isAnon, //if Anon only SignUp
        providers: [
          EmailAuthProvider(),
          GoogleProvider(clientId: DefaultFirebaseOptions.webClientId),
        ],
        headerBuilder: (context, constraints, shrinkOffset) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset('flutterfire_300x.png'),
            ),
          );
        },
        subtitleBuilder: (context, action) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Please sign up! to proceed further'),
          );
        },
        footerBuilder: (context, action) {
          return const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'By signing in, you agree to our terms and conditions.',
              style: TextStyle(color: Colors.grey),
            ),
          );
        },
        sideBuilder: (context, shrinkOffset) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset('flutterfire_300x.png'),
            ),
          );
        },
      );
    }
    final thenTo =
        Get.rootDelegate.currentConfiguration!.currentPage!.parameters?['then'];
    Get.rootDelegate.offNamed(thenTo ?? Routes.HOME);
    return const Scaffold();
  }
}
