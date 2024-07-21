import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/constants.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';

class TasksController extends GetxController {
  //TODO: Implement TasksController

  final count = 0.obs;
  var status = "waiting".obs;
  final requests = <DocumentSnapshot>[].obs;
  final firestore = FirebaseFirestore.instance;
  final functions = FirebaseFunctions.instance;
  @override
  void onInit() {
    firestore.useFirestoreEmulator(emulatorHost, 8080);
    functions.useFunctionsEmulator(emulatorHost, 5001);
    fetchRequests();
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

  void fetchRequests() {
    firestore.collection('Requests').snapshots().listen((snapshot) {
      requests.value = snapshot.docs;
    });
    status.value = "fetched";
  }

  Future<void> approveRequest(String userId) async {
    try {
      final httpsCallable = functions.httpsCallable('updateUserRole');
      final result = await httpsCallable.call({
        'userId': userId,
        'newRole': 'seller',
      });

      if (result.data['success'] == true) {
        await firestore.collection('Requests').doc(userId).update({
          'status': 'approved',
          'approvedAt': FieldValue.serverTimestamp(),
        });
      } else {
        print('Error approving request: ${result.data['error']}');
      }
    } catch (e) {
      print('Error calling function: $e');
    }
  }

  Future<void> rejectRequest(String userId) async {
    try {
      await firestore.collection('Requests').doc(userId).update({
        'status': 'rejected',
        'rejectedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error rejecting request: $e');
    }
  }

  void removeRequest(int index) {
    requests.removeAt(index);
  }
}
