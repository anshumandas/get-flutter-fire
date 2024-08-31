import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:streakzy/utils/exceptions/firebase_exceptions.dart';
import 'package:streakzy/utils/exceptions/format_exceptions.dart';
import 'package:streakzy/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import '../modules/user_profile/bindings/user_model.dart'; // Import for PlatformException

/// Repository class responsible for managing user-related data operations.
///
/// This class interacts with Firestore to save user records and handles various
/// exceptions that may occur during database operations.
class UserRepository extends GetxController {
  /// Provides an instance of `UserRepository` for easy access.
  static UserRepository get instance => Get.find();

  /// Firebase Firestore instance for database operations.
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Saves a user record to the Firestore database.
  ///
  /// This method takes a [UserModel] object and saves it to the "users" collection
  /// in Firestore using the user's ID as the document ID. It handles various exceptions
  /// that may occur during the save operation, such as Firebase-specific, format,
  /// and platform exceptions.
  ///
  /// [user]: The user data to save, encapsulated in a [UserModel] object.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message; // Handle Firebase-specific errors.
    } on FormatException catch (e) {
      throw TFormatException(e.message ?? 'Invalid format').message; // Handle format exceptions.
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message; // Handle platform-specific errors.
    } catch (e) {
      throw 'Something went wrong. Please try again!'; // Handle any other errors.
    }
  }

// Add any additional methods or logic here if needed.
}
