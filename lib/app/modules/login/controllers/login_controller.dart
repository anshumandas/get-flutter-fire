import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:get/get.dart';

import '../../../../services/auth_service.dart';

class LoginController extends GetxController {
  static AuthService get to => Get.find();

  final Rx<bool> showReverificationButton = Rx(false);

  bool get isRobot => AuthService.to.robot.value == true;

  set robot(bool v) => AuthService.to.robot.value = v;

  bool get isLoggedIn => AuthService.to.isLoggedInValue;

  bool get isAnon => AuthService.to.isAnon;

  bool get isRegistered =>
      AuthService.to.registered.value || AuthService.to.isEmailVerified;

  void verifyPhoneNumber() async {
    final fba.FirebaseAuth _auth = fba.FirebaseAuth.instance;

    await _auth.verifyPhoneNumber(
      phoneNumber: '+44 7123 123 456',
      verificationCompleted: (fba.PhoneAuthCredential credential) {
        _auth.signInWithCredential(credential);
      },
      verificationFailed: (fba.FirebaseAuthException e) {
        // Handle verification failure here
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verification ID for use when the user enters the SMS code
        // You might need to store this verificationId in a controller or state
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout
      },
    );
  }

  void signInWithPhoneNumber(String smsCode, String verificationId) async {
    final credential = fba.PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await fba.FirebaseAuth.instance.signInWithCredential(credential);
  }

  void errorMessage(String message) {
    // Handle error message display here, using the message
  }
}
