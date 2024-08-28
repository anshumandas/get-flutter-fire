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

  Future<void> updateUserData(String name, String email, String imageUrl) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'name': name,
        'email': email,
        'imageUrl': imageUrl,
      });
    } else {
      throw Exception('No user logged in');
    }
  }
}
