import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../services/firstore_service.dart';
import '../../../routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  var userData = {}.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading(true);
      DocumentSnapshot snapshot = await _firestoreService.getUserData();
      userData.value = snapshot.data() as Map<String, dynamic>;
    } finally {
      isLoading(false);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> updateUserData(String name, String email, String imageUrl) async {
    await _firestoreService.updateUserData(name, email, imageUrl);
    fetchUserData(); // Refresh the data
  }
}
