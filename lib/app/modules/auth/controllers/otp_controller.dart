import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
import 'package:get_flutter_fire/services/auth_service.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';
import 'package:get_flutter_fire/app/widgets/common/show_loader.dart';
import 'package:get_flutter_fire/app/widgets/common/show_toast.dart';

class OtpController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final AuthService authService = Get.find<AuthService>();

  var otp = ''.obs;
  var isDisabled = true.obs;
  var timerSeconds = 30.obs;
  var isResendButtonEnabled = false.obs;

  Timer? _resendTimer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        isResendButtonEnabled.value = true;
        _resendTimer?.cancel();
      }
    });
  }

  void checkOtpFields() {
    isDisabled.value = otp.value.length != 6;
  }

  Future<void> submitOtp() async {
    if (otp.value.isEmpty || otp.value.length < 6) {
      showToast('Please enter OTP');
      return;
    }

    showLoader();
    if (kDebugMode) {
      print("Phone number: ${authService.phoneNumber}");
    }

    bool success = await authService.verifyOTP(otp.value);
    dismissLoader();

    if (success) {
      await authController.fetchUserData(authService.userID);
      if (authController.user == null) {
        Get.offNamed(Routes.REGISTER,
            arguments: {'phoneNumber': authService.phoneNumber});
      } else {
        Get.offAllNamed(Routes.ROOT); // to remove screens behind home screens
      }
    } else {
      showToast('Invalid OTP');
    }
  }

  void resendCode() {
    isResendButtonEnabled.value = false;
    timerSeconds.value = 30;
    startTimer();

    // Logic to resend OTP
    authService.verifyPhoneNumber(authService.phoneNumber);
  }

  @override
  void onClose() {
    _resendTimer?.cancel();
    super.onClose();
  }
}
