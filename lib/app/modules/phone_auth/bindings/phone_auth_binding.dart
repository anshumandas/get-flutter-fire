import 'package:get/get.dart';

import '../controllers/phone_auth_controller.dart';


class MobileAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MobileAuthController>(
      () => MobileAuthController(),
    );
  }
}
