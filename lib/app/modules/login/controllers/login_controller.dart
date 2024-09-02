import 'package:get/get.dart';

import '../../../../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:get_flutter_fire/models/screens.dart';


class LoginController extends GetxController {
  static AuthService get to => Get.find();

  final Rx<bool> showReverificationButton = Rx(false);
  final Rxn<fba.EmailAuthCredential> credential = Rxn<fba.EmailAuthCredential>();
  final RxString verificationId = ''.obs;
  static const smsCode = '123456' ;
  final RxString selectedCountryCode = '+91'.obs; // Default country code

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
    AuthService.to.loginAsGuest();
  }

  void verifyPhoneNumber(String phoneNumber) {
    final fullPhoneNumber = '$selectedCountryCode$phoneNumber';
    AuthService.to.pnVerify(
      fullPhoneNumber,
          (String verificationId) {
        this.verificationId.value = verificationId;
      },
          (String userId) {
        // Handle successful verification
        Get.offAllNamed(Screen.HOME.route);
      },
    );
  }

  void signInWithSmsCode() {
    if (verificationId.isNotEmpty && smsCode.isNotEmpty) {
      AuthService.to.pnsignin(verificationId.value, smsCode);
    } else {
      Get.snackbar('Error', 'Verification ID or SMS code is empty');
    }
  }
}