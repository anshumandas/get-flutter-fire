import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/auth/controllers/auth_controller.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
import 'package:get_flutter_fire/app/widgets/common/show_loader.dart';
import 'package:get_flutter_fire/models/address_model.dart';
import 'package:uuid/uuid.dart';

class AddressController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  final line1Controller = TextEditingController();
  final line2Controller = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();

  final latitudeController = TextEditingController(text: '');
  final longitudeController = TextEditingController(text: '');

  final CollectionReference addressesRef =
      FirebaseFirestore.instance.collection('addresses');

  var addresses = <AddressModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    if (authController.currentUser.value == null) {
      Get.snackbar('Error', 'User data is not available');
      return;
    }

    fetchAddresses(); // Initial fetch
  }

  @override
  void onReady() {
    super.onReady();
    fetchAddresses(); // Fetch addresses every time the screen becomes visible
  }

  Future<void> fetchAddresses() async {
    try {
      isLoading.value = true;

      if (authController.currentUser.value == null) {
        Get.snackbar('Error', 'User is not authenticated');
        return;
      }

      if (kDebugMode) {
        print(
            'Fetching addresses for user: ${authController.currentUser.value!.id}');
      }

      final querySnapshot = await addressesRef
          .where('userID', isEqualTo: authController.currentUser.value!.id)
          .get();

      if (kDebugMode) {
        print('Fetched ${querySnapshot.docs.length} addresses');
      }

      addresses.assignAll(querySnapshot.docs
          .map(
              (doc) => AddressModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList());

      if (addresses.isEmpty) {
        log('No address found. Please add an address.', level: 1000);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching addresses: $e');
      }
      Get.snackbar('Error', 'Failed to load addresses: $e');
    } finally {
      isLoading.value = false; // End loading
    }
  }

  Future<void> saveAddress() async {
    if (authController.currentUser.value == null) {
      Get.snackbar('Error', 'User is not authenticated');
      return;
    }

    const uuid = Uuid();
    String addressID = uuid.v4();
    if (kDebugMode) {
      print("The addressID is: $addressID");
    }

    AddressModel address = AddressModel(
      name: authController.currentUser.value!.name,
      phoneNumber: authController.currentUser.value!.phoneNumber,
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
      userID: authController.currentUser.value!.id,
    );

    try {
      await addressesRef.doc(addressID).set(address.toMap());

      if (authController.currentUser.value!.defaultAddressID.isEmpty) {
        await authController.updateDefaultAddressID(addressID);
        authController.currentUser.value = authController.currentUser.value!
            .copyWith(defaultAddressID: addressID);
      }

      Get.offAllNamed(Routes.ROOT);
    } catch (e) {
      Get.snackbar('Error', 'Failed to save address: $e');
    }
  }

  Future<void> setDefaultAddress(AddressModel address) async {
    if (authController.currentUser.value == null) {
      Get.snackbar('Error', 'User is not authenticated');
      return;
    }

    showLoader();
    await authController.updateDefaultAddressID(address.id);
    await fetchAddresses();
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
