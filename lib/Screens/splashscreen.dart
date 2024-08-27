
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_flutter_fire/Screens/Loginscreen.dart';
import 'package:get_flutter_fire/Screens/mainscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    initialize(); // Start the initialization process
  }

  Future<void> initialize() async {
    try {
      print("Initializing Firebase...");
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(); // Initialize Firebase
      print("Firebase initialized");

      var user = FirebaseAuth.instance.currentUser;
      print("User status checked");

      // Navigate to the appropriate screen
      if (user == null) {
        print("Navigating to LoginScreen...");
        openLogin();
      } else {
        print("Navigating to MainScreen...");
        openMainscreen();
      }
    } catch (e) {
      print("Error during initialization: $e");
      // Handle errors if needed, like showing a retry button or message
    }
  }

  void openMainscreen() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const Mainscreen();
    }));
  }

  void openLogin() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LoginScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Splash Screen",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
          
            CircularProgressIndicator(),
          ],
        ),
      ),
      backgroundColor: Colors.blue, // Optional: set a background color
    );
  }
}
