import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_flutter_fire/constants.dart';

class BecomeSellerController extends GetxController {
  var status = "waiting".obs;
  final firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.useAuthEmulator("localhost", 9099);
  @override
  void onInit() {
    firestore.useFirestoreEmulator(emulatorHost, 8080);
    getUserRequestStatus();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<String?> getUserRequestStatus() async {
    final currentUserEmail = FirebaseAuth.instance.currentUser!.email!;

    final documentSnapshot =
        await firestore.collection('Requests').doc(currentUserEmail).get();

    if (documentSnapshot.exists) {
      final data = documentSnapshot.data();
      status.value = "pending";
      return data?['status']; // Check if data exists before accessing 'status'
    }
    status.value = "null";
    return null; // Return null if document doesn't exist
  }

  Future<void> addUserRequest() async {
    final currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
    final timeStamp = DateTime.now();

    final data = {
      "status": "pending",
      "timeStamp": timeStamp.toString(),
      "email": currentUserEmail,
    };
    status.value = "pending";

    await firestore.collection('Requests').doc(currentUserEmail).set(data);
  }
}
