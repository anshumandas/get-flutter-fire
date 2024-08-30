import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  
  void loginWithEmail() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  }
}