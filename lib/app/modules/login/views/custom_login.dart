import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/screens.dart';
import '../../../../services/auth_service.dart';

class CustomSignIn extends StatelessWidget {
  const CustomSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

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
                height: height * 0.25,
                width: width * 0.25,
              ),

              SizedBox(
                height: height * 0.02,
              ),

              // welcome back
              const Text("You were missed! Welcome Back"),
              SizedBox(height: height * 0.02),

              //username textfield
              InputWidget(
                width: width,
                emailController: emailController,
                hintText: 'Email ID',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: height * 0.02),
              //password textfield
              InputWidget(
                width: width,
                emailController: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              //forgot password?
              Padding(
                padding: EdgeInsets.only(right: width * 0.055),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          TextEditingController resetController =
                              TextEditingController();
                          Get.defaultDialog(
                            title: "Reset Passsword",
                            content: Column(
                              children: [
                                const Text("Enter your Email-ID"),
                                InputWidget(
                                    width: width,
                                    emailController: resetController,
                                    hintText: "Email",
                                    obscureText: false),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              TextButton(
                                child: const Text('Send Reset Link'),
                                onPressed: () async {
                                  try {
                                    await AuthService().resetPassword(
                                        email: resetController.text.trim());
                                    Get.snackbar('Password Reset',
                                        'A password reset link has been sent to your email.');
                                    Get.back(); // Close dialog using GetX
                                  } catch (e) {
                                    Get.snackbar(
                                        'Error', 'Failed to send reset link.');
                                    log("Error sending reset link: $e");
                                  }
                                },
                              ),
                            ],
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.grey.shade600),
                        )),
                  ],
                ),
              ),
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
                  } else if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    AuthService()
                        .login(emailController.text, passwordController.text);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  margin: EdgeInsets.symmetric(horizontal: width * 0.1),
                  height: height * 0.07,
                  width: width * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                      child: Text("Sign In",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18))),
                ),
              ),

              SizedBox(height: height * 0.05),

              //or continue with
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: width * 0.2,
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade900,
                      )),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  const Text("Or Continue with"),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  SizedBox(
                      width: width * 0.2,
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade900,
                      )),
                ],
              ),

              SizedBox(height: height * 0.02),

              //google sign in
              GestureDetector(
                onTap: () => AuthService().signInwithGoogle(),
                child: Container(
                  padding: EdgeInsets.all(width * 0.03),
                  margin: EdgeInsets.symmetric(horizontal: width * 0.08),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset('assets/icons/google.png',
                      height: height * 0.045),
                ),
              ),

              SizedBox(height: height * 0.02),

              //register now / sign up now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New user?'),
                  GestureDetector(
                      onTap: () {
                        Get.rootDelegate.toNamed(Screen.SIGNUP.route);
                      },
                      child: const Text(' Register now',
                          style: TextStyle(color: Colors.blue))),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
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
      required this.obscureText,
      this.keyboardType});

  final double width;
  final TextEditingController emailController;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;

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
