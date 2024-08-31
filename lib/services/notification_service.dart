import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_flutter_fire/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  Future<void> storeToken(String userID) async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token == null) return;
    await firestore.collection('users').doc(userID).update({
      'fcmTokens': FieldValue.arrayUnion([token])
    });
  }
}
