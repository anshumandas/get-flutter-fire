import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/role.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Rxn<User> _firebaseUser = Rxn<User>();
  final Rx<Role> _userRole = Rx<Role>(Role.buyer);
  final RxBool registered = false.obs;

  User? get user => _firebaseUser.value;
  Role get maxRole => _userRole.value;

  bool get isLoggedIn => user != null;
  bool get isEmailVerified => user?.emailVerified ?? false;
  bool get isAnonymous => user?.isAnonymous ?? false;

  String? get userName => user?.displayName ?? user?.email ?? 'Guest';

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
    ever(_firebaseUser, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    if (user != null) {
      getUserRole().then((role) {
        _userRole.value = Role.fromString(role);
      });
    }
  }

  Future<bool> checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 2)); // Simulating a network delay
    return isLoggedIn && !isAnonymous;
  }

  Future<String> getUserRole() async {
    if (user == null) return 'guest';
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(user!.uid).get();
    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
    return userData?['role'] ?? 'buyer';
  }

  Future<void> setUserRole(String role) async {
    if (user == null) throw Exception('No user logged in');
    await _firestore.collection('users').doc(user!.uid).update({'role': role});
  }

  Future<bool> signInAnonymously() async {
    try {
      await _auth.signInAnonymously();
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in anonymously: ${e.toString()}');
      return false;
    }
  }

  Future<void> createUserDocument(User user,
      {String? name, Role role = Role.buyer}) async {
    DocumentReference userDoc = _firestore.collection('users').doc(user.uid);
    DocumentSnapshot snapshot = await userDoc.get();
    if (!snapshot.exists) {
      await userDoc.set({
        'role': role.name,
        'recentlyViewed': [],
        'email': user.email,
        'name': name ?? user.displayName ?? 'User',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<AuthService> init() async {
    await Future.delayed(Duration.zero);
    return this;
  }

  Future<void> register(String email, String password, String name) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName(name);
      await createUserDocument(userCredential.user!, name: name);
      await sendEmailVerification();
    } catch (e) {
      throw Exception('Error registering: ${e.toString()}');
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await createUserDocument(userCredential.user!);
      Role userRole = await fetchUserRoleFromBackend();
      updateUserRole(userRole);
    } catch (e) {
      throw Exception('Failed to sign in: ${e.toString()}');
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      await createUserDocument(userCredential.user!);
      final cartController = Get.find<CartController>();
      await cartController.mergeGuestCart();
      return userCredential;
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in with Google: ${e.toString()}');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
      _userRole.value = Role.buyer;
    } catch (e) {
      throw Exception('Error signing out: ${e.toString()}');
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await user?.sendEmailVerification();
      Get.snackbar('Verification Email Sent',
          'Please check your email to verify your account.');
    } catch (e) {
      Get.snackbar('Error sending verification email', e.toString());
    }
  }

  Future<Role> fetchUserRoleFromBackend() async {
    // TODO: Implement this method to fetch the user's role from your backend
    await Future.delayed(Duration(seconds: 1)); // Simulating network request
    return Role.buyer; // Default role
  }

  void updateUserRole(Role newRole) {
    _userRole.value = newRole;
  }

  bool hasRole(Role role) {
    return _userRole.value.index >= role.index;
  }
}
