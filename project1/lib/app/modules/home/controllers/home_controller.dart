import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../cart/controller/cart_controller.dart';

class HomeController extends GetxController {
  late CartController cartController;
  final count = 0.obs;
  final Rx<String?> profileImageUrl = Rx<String?>(null);
  final RxString userName = RxString('');

  @override
  void onInit() {
    super.onInit();
    cartController = Get.put(CartController());
    fetchProfileInfo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void fetchProfileInfo() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      profileImageUrl.value = user.photoURL;
      userName.value = user.displayName ?? '';
    }
  }

  void updateProfileImage(String newImageUrl) {
    profileImageUrl.value = newImageUrl;
  }

  void updateProfileInfo(String name, String imageUrl) {
    userName.value = name;
    profileImageUrl.value = imageUrl;
  }

  Future<void> signOut() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && user.isAnonymous) {
        await user.delete();
      }
      await FirebaseAuth.instance.signOut();
      cartController.clear();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out: ${e.toString()}');
    }
  }
}