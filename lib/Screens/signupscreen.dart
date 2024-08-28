import 'package:flutter/material.dart';
import 'package:get_flutter_fire/Screens/mainscreen.dart';
import 'package:get_flutter_fire/controllers/signup_controller.dart';
import 'package:get_flutter_fire/services/auth_service.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Signupscreen> {

  var userForm = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController Password = TextEditingController();

  Future<void> g_signup() async {
    try {
      // Attempt to sign up with Google
      var user = await AuthService_googlesignin.g_signInOrSignUp();
      
      if (user != null) {
        // If the sign-up is successful, navigate to the main screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Mainscreen()), // Replace with your main screen widget
        );
      } else {
        // Handle case where sign-up was not successful
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google sign-up failed')),
        );
      }
    } catch (e) {
      // Handle any errors that occur during sign-up
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during Google sign-up: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up Screen")),
      body: Form(
        key: userForm,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
                decoration: const InputDecoration(label: Text("E-mail")),
              ),
              const SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: Password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  return null;
                },
                obscureText: true,
                decoration: const InputDecoration(label: Text("Password")),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (userForm.currentState!.validate()) {
                    SignupController.createaccount(
                      context: context,
                      email: email.text,
                      Password: Password.text,
                    );
                  }
                },
                child: const Text("Create Account"),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: g_signup,
                      child: const Text("Sign up with Google"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
