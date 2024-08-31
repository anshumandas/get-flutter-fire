import 'package:get/get.dart';

class ReCaptchaController extends GetxController {
  final isVerified = false.obs;

  void verifyRecaptcha() {
    // Logic for ReCaptcha verification
    isVerified.value = true;
  }
}
