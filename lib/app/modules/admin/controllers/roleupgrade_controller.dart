import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/models/role_upgrade.dart';
import 'package:get_flutter_fire/services/auth_service.dart';

class RoleUpgradeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final requests = <RoleUpgradeRequest>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    isLoading.value = true;
    try {
      final querySnapshot =
          await _firestore.collection('roleUpgradeRequests').get();
      requests.value = querySnapshot.docs
          .map((doc) => RoleUpgradeRequest.fromFirestore(doc))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch requests: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitRequest(String requestedRole) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not logged in');

      final currentRole = await AuthService.to.getUserRole();

      final request = RoleUpgradeRequest(
        id: '',
        userId: user.uid,
        currentRole: currentRole,
        requestedRole: requestedRole,
        status: 'pending',
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection('roleUpgradeRequests')
          .add(request.toFirestore());
      Get.snackbar('Success', 'Role upgrade request submitted');
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit request: $e');
    }
  }

  Future<void> updateRequestStatus(String requestId, String newStatus) async {
    try {
      await _firestore.collection('roleUpgradeRequests').doc(requestId).update({
        'status': newStatus,
      });
      await fetchRequests(); // Refresh the list
      Get.snackbar('Success', 'Request status updated');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update request status: $e');
    }
  }
}
