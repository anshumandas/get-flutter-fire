import 'package:get/get.dart';

import '../../../../services/auth_service.dart';

class RegisterController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Send email verification and logout
    AuthService.to
        .sendVerificationMail(); //if we use the EmailVerificationScreen then no need to call this
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
