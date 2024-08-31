import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';
import 'package:get_flutter_fire/enums/enums.dart';
import 'package:get_flutter_fire/models/user_model.dart';
import 'package:get_flutter_fire/services/auth_service.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';

class RegisterController extends GetxController {
  final AuthService authService = Get.find<AuthService>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final businessNameController = TextEditingController();
  final businessTypeController = TextEditingController();
  final gstNumberController = TextEditingController();
  final panNumberController = TextEditingController();

  final isBusiness = false.obs;

  void toggleBusiness(bool value) {
    isBusiness.value = value;
  }

  void registerUser(String phoneNumber) {
    String userID = authService.userID;

    UserModel user = UserModel(
      id: userID,
      name: nameController.text,
      phoneNumber: phoneNumber,
      email: emailController.text.isEmpty ? null : emailController.text,
      isBusiness: isBusiness.value,
      businessName: isBusiness.value ? businessNameController.text : null,
      businessType: isBusiness.value ? businessTypeController.text : null,
      gstNumber: isBusiness.value ? gstNumberController.text : null,
      panNumber: isBusiness.value ? panNumberController.text : null,
      userType: UserType.buyer,
      defaultAddressID: '',
      createdAt: DateTime.now(),
      lastSeenAt: DateTime.now(),
    );

    Get.find<AuthController>().registerUser(user);
    Get.toNamed(Routes.ADDRESS, arguments: {'user': user});
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    businessNameController.dispose();
    businessTypeController.dispose();
    gstNumberController.dispose();
    panNumberController.dispose();
    super.onClose();
  }
}
