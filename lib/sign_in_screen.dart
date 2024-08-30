import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'image_controller.dart'; // Import ImageController
import 'image_uploads.dart'; // Import ImageUploads (or use a different screen for handling image uploads)

class SignInScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImageController imageController = Get.put(ImageController());

  Future<void> _signInAnonymously() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      print("Signed in with temporary account: ${userCredential.user?.uid}");
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.message}");
    } catch (e) {
      print("General error: $e");
    }
  }

  Future<void> _linkWithNewCredential(AuthCredential credential) async {
    try {
      final userCredential = await FirebaseAuth.instance.currentUser!
          .linkWithCredential(credential);
      print("Account linked successfully: ${userCredential.user?.uid}");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          print("The provider has already been linked to the user.");
          break;
        case "invalid-credential":
          print("The provider's credential is not valid.");
          break;
        case "credential-already-in-use":
          print("The account corresponding to the credential already exists, or is already linked to a Firebase User.");
          break;
        default:
          print("Unknown error: ${e.message}");
      }
    } catch (e) {
      print("General error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _signInAnonymously,
              child: Text('Sign in Anonymously'),
            ),
            ElevatedButton(
              onPressed: () async {
                final GoogleSignIn googleSignIn = GoogleSignIn();
                final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
                final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

                final credential = GoogleAuthProvider.credential(
                  idToken: googleAuth.idToken,
                  accessToken: googleAuth.accessToken,
                );

                await _linkWithNewCredential(credential);
              },
              child: Text('Sign in with Google'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageUploads(), // Navigate to ImageUploads screen
                  ),
                );
              },
              child: Text('Upload Image'),
            ),
            // Add similar buttons for other providers like Email/Password
          ],
        ),
      ),
    );
  }
}
