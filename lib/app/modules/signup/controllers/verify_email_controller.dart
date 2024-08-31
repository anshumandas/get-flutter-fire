import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:streakzy/utils/constants/image_strings.dart';
import 'package:streakzy/utils/constants/text_strings.dart';
import '../../../middleware/authentication_repository.dart';
import '../../../widgets/loaders/loaders.dart';
import '../../../widgets/success_screen/success_screen.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  //Send Email verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      SLoaders.successSnackBar(
          title: 'Email Sent!', message: 'Please check your email');
    } catch (e) {
      SLoaders.errorSnackBar(title: 'oh Snap!', message: e.toString());
    }
  }

// Auto redirect after email is verified
  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
          (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(() =>
              SuccessScreen(
                  image: SImages.successCheck,
                  title: STexts.yourAccountCreatedTitle,
                  subTitle: STexts.yourAccountCreatedSubTitle,
                  onPressed: () => AuthenticationRepository.instance.screenRedirect(),
              ),
          );
        }
      },
    );
  }

  checkEmailVerificationStatus() async{
    final currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null && currentUser.emailVerified){
      Get.off(
          () => SuccessScreen(
              image: SImages.successCheck,
              title: STexts.yourAccountCreatedTitle,
              subTitle: STexts.yourAccountCreatedSubTitle,
              onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ),
      );
    }
  }
}
