import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/models/user_model.dart';
import 'package:get_flutter_fire/enums/enums.dart';

class ApproveSellerController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var usersToApprove = <UserModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsersToApprove(); // Fetch users on initialization
  }

  Future<void> fetchUsersToApprove() async {
    try {
      isLoading.value = true;
      final querySnapshot = await _firestore
          .collection('users')
          .where('isBusiness', isEqualTo: true)
          .where('userType', isEqualTo: 'buyer')
          .get();

      usersToApprove.value = querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch users: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> approveSeller(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).update({
        'userType': 'seller',
      });

      user = user.copyWith(userType: UserType.seller);
      usersToApprove.removeWhere((u) => u.id == user.id); // Remove from list

      Get.snackbar('Success', 'User ${user.name} approved as a seller');
    } catch (e) {
      Get.snackbar('Error', 'Failed to approve seller: $e');
    }
  }
}
