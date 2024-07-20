import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/models/role_requests.dart';

class RoleRequestController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var roleRequests = <RoleRequest>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRoleRequests();
  }

  void fetchRoleRequests() {
    _firestore.collection('role_requests').snapshots().listen((snapshot) {
      roleRequests.value = snapshot.docs
          .map((doc) => RoleRequest.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  void addRoleRequest(RoleRequest request) async {
    await _firestore.collection('role_requests').add(request.toMap());
  }

  void approveRoleRequest(String requestId) async {
    await _firestore
        .collection('role_requests')
        .doc(requestId)
        .update({'approved': true});
  }
}
