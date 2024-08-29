import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return _firestore.collection('users').doc(user.uid).get();
    } else {
      throw Exception('No user logged in');
    }
  }

  Future<void> updateUserData({
    required String name,
    required String email,
    required String phoneNumber,
    String imageUrl = 'https://via.placeholder.com/150',
    bool isEmailVerified = false,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
        'isEmailVerified': isEmailVerified,
      });
    } else {
      throw Exception('No user logged in');
    }
  }
}
