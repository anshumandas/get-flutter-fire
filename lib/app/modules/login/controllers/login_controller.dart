import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:get/get.dart';

import '../../../../services/auth_service.dart';

class LoginController extends GetxController {
  static AuthService get to => Get.find();

  final Rx<bool> showReverificationButton = Rx(false);
  final Rxn<fba.EmailAuthCredential> credential = Rxn<fba.EmailAuthCredential>();
  final RxString verificationId = ''.obs;
  

  bool get isRobot => AuthService.to.robot.value == true;

  set robot(bool v) => AuthService.to.robot.value = v;

  bool get isLoggedIn => AuthService.to.isLoggedInValue;

  bool get isAnon => AuthService.to.isAnon;

  bool get isRegistered =>
      AuthService.to.registered.value || AuthService.to.isEmailVerified;

  void sendVerificationMail({fba.EmailAuthCredential? emailAuth}) {
    AuthService.to.sendVerificationMail(emailAuth: emailAuth);
  }
  void guestlogin() {
    AuthService.to.guestlogin();
  }

}



