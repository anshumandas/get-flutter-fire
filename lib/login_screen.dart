import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../home_screen.dart';
import '../services/auth_services.dart';
import '../signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: Color(0xFF1d2630),
        foregroundColor: Colors.white,
        title: Text('Sign In'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(children: [
            SizedBox(height: 50),
            Text(
              "Welcome Back!",
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Login Here!",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40.0),
            TextField(
              controller: _emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white60),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white60),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              style: TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white60),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white60),
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width / 1.5,
              child: ElevatedButton(
                onPressed: () async {
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();

                  if (email.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Email is required."),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  if (password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Password is required."),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  try {
                    User? user = await _auth.signInWithEmailAndPassword(email, password);
                    if (user != null) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    }
                  } catch (e) {
                    if (e is FirebaseAuthException) {
                      print('FirebaseAuthException code: ${e.code}');  // Debug log
                      switch (e.code) {
                        case 'user-not-found':
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("No user found with this email."),
                              backgroundColor: Colors.red,
                            ),
                          );
                          break;
                        case 'wrong-password':
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Incorrect password."),
                              backgroundColor: Colors.red,
                            ),
                          );
                          break;
                        case 'invalid-email':
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Invalid email address."),
                              backgroundColor: Colors.red,
                            ),
                          );
                          break;
                        default:
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("An error occurred. Please try again."),
                              backgroundColor: Colors.red,
                            ),
                          );
                          break;
                      }
                    } else {
                      // Handle any other exceptions
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("An unexpected error occurred. Please try again."),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  "Log In",
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "OR",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
              },
              child: Text(
                "Create Account",
                style: TextStyle(fontSize: 25.0),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
