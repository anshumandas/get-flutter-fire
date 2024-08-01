import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:get_flutter_fire/models/screens.dart';
import '../../../../services/auth_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:country_code_picker/country_code_picker.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  final AuthService _authService = Get.find();
  final GetStorage _storage = GetStorage();

  final Rx<bool> showReverificationButton = Rx(false);
  final Rx<bool> isRecaptchaVerified = Rx(false);
  final Rxn<fba.AuthCredential> credential = Rxn<fba.AuthCredential>();

  final Rx<String> verificationId = Rx<String>('');
  final Rx<bool> isCodeSent = Rx<bool>(false);
  final Rx<bool> isPhoneLoginMode = Rx<bool>(false);
  final Rx<bool> isOtpMode = Rx<bool>(false);

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController smsController = TextEditingController();

  final Rx<CountryCode> selectedCountry = Rx<CountryCode>(CountryCode(
    name: "India",
    code: "IN",
    dialCode: "+91",
  ));

  bool get isLoggedIn => _authService.isLoggedInValue;
  bool get isAnon => _authService.isAnon;
  bool get isRegistered => _authService.registered.value || _authService.isEmailVerified;

  @override
  void onInit() {
    super.onInit();
    isPhoneSignedIn = _storage.read('isPhoneSignedIn') ?? false;
  }

  Future<bool> verifyRecaptcha() async {
    if (GetPlatform.isWeb) {
      try {
        print('Attempting reCAPTCHA verification...');
        final result = await GRecaptchaV3.execute('login_action');
        print('reCAPTCHA result: $result');
        if (result != null && result.isNotEmpty) {
          print('reCAPTCHA verification successful');
          isRecaptchaVerified.value = true;
          return true;
        } else {
          print('reCAPTCHA verification failed: Empty or null result');
        }
      } catch (e) {
        print('reCAPTCHA error: $e');
        isRecaptchaVerified.value = false;
      }
      return false;
    } else {
      print('Non-web platform, assuming verified');
      isRecaptchaVerified.value = true;
      return true;
    }
  }

  Future<void> sendSMSCode(String phoneNumber) async {
    try {
      await _authService.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) async {
          await _authService.signInWithCredential(credential);
          _completePhoneSignIn(phoneNumber);
        },
        verificationFailed: (e) {
          print('Verification failed: ${e.message}');
          Get.snackbar('Error', 'Failed to send verification code');
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
          isCodeSent.value = true;
          isOtpMode.value = true;
          Get.snackbar('Code Sent', 'Please enter the verification code');
          // Add this line to update the UI
          update();
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },
      );
    } catch (e) {
      print('Error sending SMS code: $e');
      Get.snackbar('Error', 'Failed to send verification code');
    }
  }

  Future<void> verifySMSCode(String smsCode) async {
    try {
      final credential = fba.PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: smsCode,
      );
      await _authService.signInWithCredential(credential);

      Get.snackbar(
        'Success',
        'Login Successful',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );

      // Wrap _completePhoneSignIn in another try-catch block
      try {
        _completePhoneSignIn("${selectedCountry.value.dialCode}${phoneController.text}");
      } catch (e) {
        print('Error in _completePhoneSignIn: $e');
        // Optionally, you can show another snackbar here if needed
      }
    } catch (e) {
      print('Error verifying SMS code: $e');

      String errorMessage = 'Invalid verification code';
      if (e is fba.FirebaseAuthException) {
        switch (e.code) {
          case 'invalid-verification-code':
            errorMessage = 'The verification code is invalid. Please try again.';
            break;
          case 'invalid-verification-id':
            errorMessage = 'The verification ID is invalid. Please request a new code.';
            break;
          default:
            errorMessage = 'An error occurred during verification. Please try again.';
        }
      }

      Get.snackbar(
        'Error',
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void _completePhoneSignIn(String phoneNumber) {
    _storage.write('isPhoneSignedIn', true);
    _storage.write('phoneNumber', phoneNumber);
    isPhoneSignedIn = true;

    // Add a small delay before navigation
    Future.delayed(Duration(seconds: 2), () {
      Get.offNamed(Screen.HOME.route);
    });
  }

  bool get isPhoneSignedIn => _storage.read('isPhoneSignedIn') ?? false;
  set isPhoneSignedIn(bool value) => _storage.write('isPhoneSignedIn', value);

  String? get signedInPhoneNumber => _storage.read('phoneNumber');

  void errorMessage(BuildContext context, AuthFailed state, Function(bool, fba.AuthCredential?) showReverificationButton) {
    // Implement your error handling here
  }

  void sendVerificationMail({fba.AuthCredential? emailAuth}) {
    // Implement sending verification mail if needed
  }
}