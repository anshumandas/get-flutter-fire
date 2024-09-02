import 'package:get/get.dart';

class AuthController extends GetxController {
  final phoneNumber = ''.obs;
  final smsCode = ''.obs;

  void sendSmsCode() {
    // Logic to send SMS code
    Get.snackbar('Success', 'SMS code sent!');
  }

  void verifySmsCode() {
    // Logic to verify SMS code and complete login
    Get.snackbar('Success', 'Phone number verified!');
  }
}
