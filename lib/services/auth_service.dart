import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../app/routes/app_pages.dart';
import '../models/euser.dart';
import '../services/firestore_service.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  final Rxn<User> _firebaseUser = Rxn<User>();

  User? get currentUser => _firebaseUser.value;

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Fetch user data from Firestore using email as the document ID
      DocumentSnapshot userDoc = await _firestoreService.getUserByEmail(email);
      if (userDoc.exists) {
        EUser eUser = EUser.fromMap(userDoc.data() as Map<String, dynamic>);
        // Optionally, you can save eUser in a state management solution if needed
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar("Error", "User data could not be retrieved.");
      }
    } catch (e) {
      Get.snackbar("Login failed", e.toString());
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      // Create the user with Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      // Show loading indicator and wait for verification
      await _auth.currentUser!.reload();
      while (!_auth.currentUser!.emailVerified) {
        await Future.delayed(Duration(seconds: 3));
        await _auth.currentUser!.reload();
      }

      // Once verified, create user data in Firestore
      EUser newUser = EUser(
        id: userCredential.user!.uid,
        name: name,
        email: email,
      );
      await _firestoreService.createUser(newUser);

      // Navigate to home after successful registration
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar("Registration failed", e.toString());
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Password reset email sent. Please check your inbox.");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
