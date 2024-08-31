import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';
import 'package:get_flutter_fire/app/modules/seller/controllers/seller_controller.dart';
import 'package:get_flutter_fire/enums/enums.dart';

class RootController extends GetxController {
  var selectedIndex = 0.obs;

  final AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();

    if (authController.user?.userType == UserType.seller) {
      Get.put(SellerController());
    }
  }

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
