import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';
import 'package:get_flutter_fire/app/modules/home/controllers/home_controller.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
import 'package:get_flutter_fire/app/widgets/common/show_loader.dart';
import 'package:get_flutter_fire/models/address_model.dart';
import 'package:get_flutter_fire/models/user_model.dart';
import 'package:uuid/uuid.dart';

class AddressController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  final line1Controller = TextEditingController();
  final line2Controller = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();

  final latitudeController = TextEditingController(text: '');
  final longitudeController = TextEditingController(text: '');

  late UserModel user;
  final CollectionReference addressesRef =
      FirebaseFirestore.instance.collection('addresses');

  var addresses = <AddressModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    try {
      if (Get.arguments != null && Get.arguments.containsKey('user')) {
        user = Get.arguments['user'] as UserModel;
      } else {
        if (authController.currentUser.value != null) {
          user = authController.currentUser.value!;
        }
      }
      final querySnapshot =
          await addressesRef.where('userID', isEqualTo: user.id).get();

      addresses.assignAll(querySnapshot.docs
          .map(
              (doc) => AddressModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      Get.snackbar('Error', 'Failed to load addresses: $e');
    }
  }

  void saveAddress() async {
    const uuid = Uuid();
    String addressID = uuid.v4();

    AddressModel address = AddressModel(
      name: user.name,
      phoneNumber: user.phoneNumber,
      line1: line1Controller.text,
      line2: line2Controller.text,
      city: cityController.text,
      district: districtController.text,
      latitude: latitudeController.text.isEmpty
          ? 0.0
          : double.parse(latitudeController.text),
      longitude: longitudeController.text.isEmpty
          ? 0.0
          : double.parse(longitudeController.text),
      id: addressID,
      userID: user.id,
    );

    try {
      await addressesRef.doc(addressID).set(address.toMap());

      if (user.defaultAddressID.isEmpty) {
        await authController.updateDefaultAddressID(addressID);

        user = user.copyWith(defaultAddressID: addressID);
      }

      Get.offAllNamed(Routes.ROOT);
    } catch (e) {
      Get.snackbar('Error', 'Failed to save address: $e');
    }
  }

  Future<void> setDefaultAddress(AddressModel address) async {
    showLoader();
    await authController.updateDefaultAddressID(address.id);
    await fetchAddresses();
    final homeController = Get.find<HomeController>();
    await homeController.fetchOffersForUserLocation();
    dismissLoader();
  }

  Future<void> deleteAddress(String id) async {
    try {
      await addressesRef.doc(id).delete();
      addresses.removeWhere((address) => address.id == id);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete address: $e');
    }
  }

  @override
  void onClose() {
    line1Controller.dispose();
    line2Controller.dispose();
    cityController.dispose();
    districtController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.onClose();
  }
}
