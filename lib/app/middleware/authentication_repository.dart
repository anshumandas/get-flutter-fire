import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:streakzy/navigation_menu.dart';
import 'package:streakzy/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:streakzy/utils/exceptions/firebase_exceptions.dart';
import 'package:streakzy/utils/exceptions/format_exceptions.dart';
import 'package:streakzy/utils/exceptions/platform_exceptions.dart';

import '../modules/login/bindings/login.dart';
import '../modules/onboarding/views/onboarding.dart';
import '../modules/signup/views/verify_email.dart';

/// Controller class responsible for managing authentication logic.
///
/// This class uses Firebase Authentication and GetX for state management.
/// It handles user login, registration, email verification, and logout,
/// and provides redirection logic based on the user's authentication state.
class AuthenticationRepository extends GetxController {
  /// Provides an instance of `AuthenticationRepository` for easy access.
  static AuthenticationRepository get instance => Get.find();

  // Variables for accessing device storage and Firebase Authentication.
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Called automatically when the controller is initialized and ready.
  ///
  /// This method is invoked when the app launches, and it removes the native splash screen
  /// before performing a screen redirection based on the user's authentication status.
  @override
  void onReady() {
    FlutterNativeSplash.remove(); // Removes the native splash screen.
    screenRedirect(); // Redirects the user based on their authentication status.
  }

  /// Redirects the user to the appropriate screen based on their authentication status.
  ///
  /// If the user is authenticated and their email is verified, they are redirected to the main navigation menu.
  /// Otherwise, the user is redirected to either the email verification screen, login screen, or onboarding screen.
  void screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      // If the user is authenticated and their email is verified.
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        // If the user's email is not verified.
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      // If the user is not authenticated.
      deviceStorage.writeIfNull('isFirstTime',
          true); // Write to local storage if the key doesn't exist.
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen()) // Redirect to login screen.
          : Get.offAll(
              const OnBoardingScreen()); // Redirect to onboarding screen if it's the first time.
    }

    // Debugging information (uncomment for debugging purposes).
    // if (kDebugMode) {
    //   print('-------------Get Storage----------------');
    //   print(deviceStorage.read('IsFirstTime'));
    // }
  }

  ///LOGIN

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code)
          .message; // Handle FirebaseAuth-specific errors.
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code)
          .message; // Handle general Firebase errors.
    } on FormatException catch (_) {
      throw const TFormatException(); // Handle format exceptions.
    } on PlatformException catch (e) {
      throw TPlatformException(e.code)
          .message; // Handle platform-specific errors.
    } catch (e) {
      throw 'Something went wrong. Please try again!'; // Handle any other errors.
    }
  }

  /// Registers a user with an email and password.
  ///
  /// This method interacts with Firebase to create a new user account.
  /// If an error occurs during registration, it throws an appropriate exception message.
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code)
          .message; // Handle FirebaseAuth-specific errors.
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code)
          .message; // Handle general Firebase errors.
    } on FormatException catch (_) {
      throw const TFormatException(); // Handle format exceptions.
    } on PlatformException catch (e) {
      throw TPlatformException(e.code)
          .message; // Handle platform-specific errors.
    } catch (e) {
      throw 'Something went wrong. Please try again!'; // Handle any other errors.
    }
  }

  /// Sends an email verification to the current user.
  ///
  /// This method sends a verification email to the user's registered email address.
  /// It handles any exceptions that may occur during the process.
  Future<void> sendEmailVerification() async {
    try {
      return await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code)
          .message; // Handle FirebaseAuth-specific errors.
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code)
          .message; // Handle general Firebase errors.
    } on FormatException catch (_) {
      throw const TFormatException(); // Handle format exceptions.
    } on PlatformException catch (e) {
      throw TPlatformException(e.code)
          .message; // Handle platform-specific errors.
    } catch (e) {
      throw 'Something went wrong. Please try again!'; // Handle any other errors.
    }
  }

  //Forget Password

  Future<void> sendPasswordResetEmail(String email) async {
    try {
        await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code)
          .message; // Handle FirebaseAuth-specific errors.
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code)
          .message; // Handle general Firebase errors.
    } on FormatException catch (_) {
      throw const TFormatException(); // Handle format exceptions.
    } on PlatformException catch (e) {
      throw TPlatformException(e.code)
          .message; // Handle platform-specific errors.
    } catch (e) {
      throw 'Something went wrong. Please try again!'; // Handle any other errors.
    }
  }

  // Google Auth

  Future<UserCredential> signInWithGoogle() async {
    try {
      //trigger authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      //obtain auth details
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      // create new credential
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      //once signed in, return the user credential
      return await _auth.signInWithCredential(credentials);

    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code)
          .message; // Handle FirebaseAuth-specific errors.
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code)
          .message; // Handle general Firebase errors.
    } on FormatException catch (_) {
      throw const TFormatException(); // Handle format exceptions.
    } on PlatformException catch (e) {
      throw TPlatformException(e.code)
          .message; // Handle platform-specific errors.
    } catch (e) {
      throw 'Something went wrong. Please try again!'; // Handle any other errors.
    }
  }

  /// Logs out the current user from the app.
  ///
  /// This method signs out the current user from Firebase and handles any errors that may occur.
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code)
          .message; // Handle FirebaseAuth-specific errors.
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code)
          .message; // Handle general Firebase errors.
    } on FormatException catch (_) {
      throw const TFormatException(); // Handle format exceptions.
    } on PlatformException catch (e) {
      throw TPlatformException(e.code)
          .message; // Handle platform-specific errors.
    } catch (e) {
      throw 'Something went wrong. Please try again!'; // Handle any other errors.
    }
  }
}
