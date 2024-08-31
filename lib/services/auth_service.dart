import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService_googlesignin {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Function to handle Google Sign-In/Sign-Up
  static Future<User?> g_signInOrSignUp() async {
    try {
      // Sign out from Google to force account picker
      await _googleSignIn.signOut();

      // Trigger the Google Sign-In process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        // The user canceled the sign-in process
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print("Error during Google Sign-In/Sign-Up: $e");
      return null;
    }
  }
}
