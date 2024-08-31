import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
import 'package:get_flutter_fire/models/address_model.dart';
import 'package:get_flutter_fire/constants.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  String _verificationId = '';
  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;

  String get userID => auth.currentUser!.uid;

  // Save the address to Firestore
  Future<void> saveAddress(AddressModel address) async {
    try {
      await FirebaseFirestore.instance
          .collection('addresses')
          .doc(address.id)
          .set(address.toMap());
    } catch (e) {
      Get.snackbar('Error', 'Failed to save address: $e');
    }
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    _phoneNumber = phoneNumber;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'Invalid Phone Number. Please try again.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        Get.toNamed(Routes.OTP, arguments: {'phoneNumber': _phoneNumber});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: otp);
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        return true;
      }
      return false;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-verification-code') {
        Get.snackbar('Error', 'Invalid OTP. Please try again.');
      }
      return false;
    }
  }
}
