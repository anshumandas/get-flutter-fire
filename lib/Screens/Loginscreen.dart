import 'package:flutter/material.dart';
import 'package:get_flutter_fire/Screens/mainscreen.dart';
import 'package:get_flutter_fire/Screens/signupscreen.dart';
import 'package:get_flutter_fire/controllers/login_controller.dart';
import 'package:get_flutter_fire/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userForm = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> g_signin() async {
    try {
      var user = await AuthService_googlesignin.g_signInOrSignUp();

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Mainscreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google sign-in failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error during Google sign-in: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: userForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                decoration: const InputDecoration(labelText: "E-mail"),
              ),
              const SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  return null;
                },
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (userForm.currentState!.validate()) {
                    LoginController.loginaccount(
                      context: context,
                      email: email.text,
                      Password: password.text,
                    );
                  }
                },
                child: const Text("Login"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Signupscreen()),
                      );
                    },
                    child: const Text(
                      "Signup here",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: g_signin,
                child: const Text("Sign in with Google"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
