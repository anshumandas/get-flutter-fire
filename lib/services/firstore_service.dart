import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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
    File? imageFile,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? imageUrl;

      if (imageFile != null) {
        // Upload the image to Firebase Storage
        UploadTask uploadTask = _storage
            .ref('user_images/${user.uid}.jpg')
            .putFile(imageFile);

        TaskSnapshot taskSnapshot = await uploadTask;
        imageUrl = await taskSnapshot.ref.getDownloadURL();

        // Download the image locally for display
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String localPath = '${appDocDir.path}/user_${user.uid}.jpg';
        File localFile = File(localPath);

        Uint8List? imageData = await taskSnapshot.ref.getData();
        if (imageData != null) {
          await localFile.writeAsBytes(imageData);
        }
      }

      await _firestore.collection('users').doc(user.uid).update({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        if (imageUrl != null) 'imageUrl': imageUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } else {
      throw Exception('No user logged in');
    }
  }
}
