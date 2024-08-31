import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:streakzy/utils/constants/image_strings.dart';
import 'package:streakzy/utils/helpers/network_manager.dart';
import 'package:streakzy/utils/popups/full_screen_loader.dart';

import '../../../middleware/authentication_repository.dart';
import '../../../widgets/loaders/loaders.dart';
import '../../user_profile/controllers/user_controller.dart';

class LoginController extends GetxController{

  //variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email =  TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
     // email.text = localStorage.read('REMEMBER_ME_EMAIL');
     // password.text = localStorage.read('REMEMBER_ME_PASSWORD');
    super.onInit();
  }


  /// Email and password signin
  Future<void> emailAndPasswordSignIn() async {
    try{
      //start loading
      SFullScreenLoader.openLoadingDialog('Logging you in..', SImages.docerAnimation);

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      //  Form Validation

      if (!loginFormKey.currentState!.validate()) {
        SFullScreenLoader.stopLoading();
        return;
      }

      //save Data if remember me is selected
      if(rememberMe.value){
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      //login user pswd auth

      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //Remove loader
      SFullScreenLoader.stopLoading();

      //redirect
      AuthenticationRepository.instance.screenRedirect();

    }
    catch (e) {
      // Handle exceptions
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Google OAuth
  Future<void> googleSignIn() async {
    try{
      //start Loading
      SFullScreenLoader.openLoadingDialog('Logging you in..', SImages.docerAnimation);

      //check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      //Google Auth
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      //save user record
      await userController.saveUserRecord(userCredentials);

      //remove loader
      SFullScreenLoader.stopLoading();

      //redirect
      AuthenticationRepository.instance.screenRedirect();

    }catch(e){
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'oh Snap', message: e.toString());
    }
  }


}