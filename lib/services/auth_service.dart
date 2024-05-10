import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();

  User? get user => _firebaseUser.value;

  @override
  onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  bool get isLoggedInValue => user != null;

  void login() {
    // this is not needed as we are using Firebase UI for the login part
  }

  void logout() {
    _auth.signOut();
    _firebaseUser.value = null;
  }
}
