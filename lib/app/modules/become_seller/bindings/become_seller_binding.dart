import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/become_seller/controllers/become_seller_controller.dart';

class BecomeSellerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BecomeSellerController>(
      () => BecomeSellerController(),
    );
  }
}
