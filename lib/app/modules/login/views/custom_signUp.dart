// ignore_for_file: file_names

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/screens.dart';
import '../../../../services/auth_service.dart';

class CustomSignUp extends GetView<AuthController> {
  const CustomSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmpasswordController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.02),

              //logo
              Image.asset(
                'assets/icons/logo.png',
                height: height * 0.2,
                width: width * 0.2,
              ),

              SizedBox(height: height * 0.01),

              // welcome back
              const Text("Welcome Aboard! Let's have a great time."),
              SizedBox(height: height * 0.02),

              //username textfield
              InputWidget(
                width: width,
                emailController: emailController,
                hintText: 'Email ID',
                obscureText: false,
              ),
              SizedBox(height: height * 0.01),
              //password textfield
              InputWidget(
                width: width,
                emailController: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              SizedBox(height: height * 0.01),
              //password textfield
              InputWidget(
                width: width,
                emailController: confirmpasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              SizedBox(height: height * 0.03),

              //sign in button
              GestureDetector(
                onTap: () {
                  if (emailController.text.isEmpty ||
                      !emailController.text.contains('@')) {
                    Get.snackbar(
                      'Invalid Email',
                      "Please enter a valid email id.",
                    );
                  } else if (passwordController.text.isEmpty ||
                      passwordController.text.length < 6) {
                    Get.snackbar(
                      'Invalid Password',
                      "Please enter a password longer than 6 letters.",
                    );
                  } else if (passwordController.text ==
                      confirmpasswordController.text) {
                    AuthService()
                        .login(emailController.text, passwordController.text);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(width * 0.05),
                  margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                      child: Text("Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18))),
                ),
              ),

              SizedBox(height: height * 0.05),

              // //or continue with
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SizedBox(
              //         width: width * 0.2,
              //         child: Divider(
              //           thickness: 0.5,
              //           color: Colors.grey.shade900,
              //         )),
              //     SizedBox(
              //       width: width * 0.05,
              //     ),
              //     const Text("Or Continue with"),
              //     SizedBox(
              //       width: width * 0.05,
              //     ),
              //     SizedBox(
              //         width: width * 0.2,
              //         child: Divider(
              //           thickness: 0.5,
              //           color: Colors.grey.shade900,
              //         )),
              //   ],
              // ),

              // SizedBox(height: height * 0.01),

              // //google sign in
              // GestureDetector(
              //   onTap: () => AuthService().signInwithGoogle(),
              //   child: Container(
              //     padding: EdgeInsets.all(width * 0.03),
              //     margin: EdgeInsets.symmetric(horizontal: width * 0.1),
              //     decoration: BoxDecoration(
              //       color: Colors.grey.shade200,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Image.asset('assets/icons/google.png',
              //         height: height * 0.045),
              //   ),
              // ),

              SizedBox(height: height * 0.01),

              //register now / sign up now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Exisiting user?'),
                  GestureDetector(
                      onTap: () {
                        Get.rootDelegate.toNamed(Screen.LOGIN.route);
                        // print(Get.rootDelegate.history);
                      },
                      child: const Text(' Sign In',
                          style: TextStyle(color: Colors.blue))),
                ],
              ),
              SizedBox(height: height * 0.1)
            ],
          ),
        ),
      ),
    );
  }
}

class InputWidget extends StatelessWidget {
  const InputWidget(
      {super.key,
      required this.width,
      required this.emailController,
      required this.hintText,
      required this.obscureText});

  final double width;
  final TextEditingController emailController;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
      child: TextField(
        controller: emailController,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText),
        obscureText: obscureText,
      ),
    );
  }
}
