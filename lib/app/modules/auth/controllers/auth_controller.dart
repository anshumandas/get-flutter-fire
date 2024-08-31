import 'package:get/get.dart';
import 'package:get_flutter_fire/enums/enums.dart';
import 'package:get_flutter_fire/models/user_model.dart';
import 'package:get_flutter_fire/constants.dart';
import 'package:get_flutter_fire/services/get_storage_service.dart';
import 'package:get_flutter_fire/app/modules/seller/controllers/seller_controller.dart';

class AuthController extends GetxController {
  final GetStorageService _storageService = GetStorageService();

  var isLoading = false.obs;
  final Rxn<UserModel> _user = Rxn<UserModel>();

  UserModel? get user => _user.value;

  Rxn<UserModel> get currentUser => _user;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
    _checkForUserRoleUpdate();
  }

  void _loadUserData() {
    final storedUser = _storageService.getUserData();
    if (storedUser != null) {
      _user.value = storedUser;
    }
  }

  Future<void> _checkForUserRoleUpdate() async {
    if (_user.value == null) return;

    isLoading.value = true;
    try {
      var doc = await usersRef.doc(_user.value!.id).get();
      if (doc.exists) {
        UserModel updatedUser = UserModel.fromMap(doc.data()!);
        if (updatedUser.userType != _user.value!.userType) {
          _user.value = updatedUser;
          _storageService.saveUserData(updatedUser);

          if (updatedUser.userType == UserType.seller) {
            final SellerController sellerController =
                Get.put(SellerController());
            await sellerController.onUserRoleChanged(updatedUser);
          }
        }
      }
    } catch (error) {
      _handleError('Failed to check user role');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUserData(String userID) async {
    isLoading.value = true;
    try {
      var doc = await usersRef.doc(userID).get();
      if (doc.exists) {
        _user.value = UserModel.fromMap(doc.data()!);
        _storageService.saveUserData(_user.value!);

        if (_user.value!.userType == UserType.seller) {
          final SellerController sellerController = Get.put(SellerController());
          await sellerController.onUserRoleChanged(_user.value!);
        }
      }
    } catch (error) {
      _user.value = null;
      _handleError('Failed to fetch user data');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> registerUser(UserModel user) async {
    isLoading.value = true;
    try {
      await usersRef.doc(user.id).set(user.toMap());
      _user.value = user;
      _storageService.saveUserData(user);
    } catch (error) {
      _handleError('Failed to register user');
    } finally {
      isLoading.value = false;
    }
  }

  // Updated method to set default address
  Future<void> updateDefaultAddressID(String addressID) async {
    if (_user.value == null) return;

    try {
      await usersRef
          .doc(_user.value!.id)
          .update({'defaultAddressID': addressID});
      _user.value = _user.value!.copyWith(defaultAddressID: addressID);
      _storageService.saveUserData(_user.value!);
    } catch (e) {
      _handleError('Failed to update user address: $e');
    }
  }

  // Updated method to handle user address
  Future<void> updateUserAddress(UserModel user, String addressID) async {
    try {
      await usersRef.doc(user.id).update({'defaultAddressID': addressID});
      _user.value = _user.value!.copyWith(defaultAddressID: addressID);
      _storageService.saveUserData(_user.value!);
    } catch (e) {
      _handleError('Failed to update user address: $e');
    }
  }

  void _handleError(String message) {
    Get.snackbar('Error', message);
  }

  void clearUserData() {
    _user.value = null;
    _storageService.clearUserData();
  }
}
