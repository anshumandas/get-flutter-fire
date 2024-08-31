import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:streakzy/utils/constants/image_strings.dart';
import 'package:streakzy/utils/helpers/network_manager.dart';
import 'package:streakzy/utils/popups/full_screen_loader.dart';
import '../../../middleware/authentication_repository.dart';
import '../../../middleware/user_repository.dart';
import '../../../widgets/loaders/loaders.dart';
import '../../user_profile/bindings/user_model.dart';
import '../views/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Variable keys for processing data
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  @override
  void onClose() {
    // Dispose the TextEditingControllers to free resources
    email.dispose();
    lastName.dispose();
    username.dispose();
    password.dispose();
    firstName.dispose();
    phoneNumber.dispose();
    super.onClose();
  }

  void signup() async {
    try {
      // Start loading
      SFullScreenLoader.openLoadingDialog(
        'We are Processing Your Information...',
        SImages.docerAnimation,
      );

      // Check Internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      // Privacy policy check
      if (!privacyPolicy.value) {
        SFullScreenLoader.stopLoading();
        // SFullScreenLoader.stopLoading(); // Stop the loader if privacy policy is not accepted
        SLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message: 'In order to create an account, you need to accept the privacy policy.',
        );

        return;
      }

      // Register user to Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save data to Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      SFullScreenLoader.stopLoading();

      // Success message
      SLoaders.successSnackBar(
          title: 'Congratulations', message: 'Your account has been created.');

      // Navigate to the verify email screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim())); // Ensure VerifyEmailScreen is correctly imported

    } catch (e) {
      // Handle exceptions
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
