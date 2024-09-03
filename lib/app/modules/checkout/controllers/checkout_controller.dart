import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:get_flutter_fire/models/cart_item.dart';

class CheckoutController extends GetxController {
  final CartController cartController = Get.find<CartController>();

  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();

  final selectedPaymentMethod = 'Credit Card'.obs;
  final isLoading = false.obs;

  List<CartItem> get cartItems => cartController.cartItems;
  double get totalAmount => cartController.totalPrice;

  @override
  void onClose() {
    addressController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    super.onClose();
  }

  void processCheckout() async {
    if (addressController.text.isEmpty ||
        cityController.text.isEmpty ||
        postalCodeController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all shipping details');
      return;
    }

    isLoading.value = true;

    // Simulating a network request
    await Future.delayed(Duration(seconds: 2));

    // Here you would typically send the order to your backend
    // For now, we'll just show a success message and clear the cart

    isLoading.value = false;

    Get.snackbar(
      'Success',
      'Your order has been placed successfully!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    cartController.clearCart();
    Get.offAllNamed('/home'); // Navigate back to home page
  }
}
