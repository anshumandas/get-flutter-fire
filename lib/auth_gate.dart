import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account: ${userCredential.user?.uid}");
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.message}");
      if (e.code == "operation-not-allowed") {
        print("Anonymous auth hasn't been enabled for this project.");
      } else {
        print("Unknown error: ${e.message}");
      }
    } catch (e) {
      print("General error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
              GoogleProvider(clientId: "YOUR_CLIENT_ID.apps.googleusercontent.com"),
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
                    ? const Text('Welcome to FlutterFire, please sign in!')
                    : const Text('Welcome to Flutterfire, please sign up!'),
              );
            },
            footerBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextButton(
                  onPressed: () => _signInAnonymously(context),
                  child: const Text('Sign in Anonymously'),
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



        return const HomeScreen();
      },
    );
  }
}
