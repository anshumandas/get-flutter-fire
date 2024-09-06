import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import '../views/checkout_view.dart';
import 'package:flutter/services.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';

class CheckoutController extends GetxController {
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();
  final cardHolderNameController = TextEditingController();
  final addressController = TextEditingController(); 

  final CartController cartController = Get.find<CartController>();

  RxString cardNumberError = ''.obs;
  RxString expiryDateError = ''.obs;
  RxString cvvError = ''.obs;
  RxString cardHolderNameError = ''.obs;
  RxString addressError = ''.obs;

  final formKey = GlobalKey<FormState>();

  void onCheckoutPressed(double totalAmount) {
    if (formKey.currentState?.validate() == true) {
      // Simulate payment verification
      Future.delayed(Duration(seconds: 2), () {
        if (totalAmount > 0) {
          cartController.cartItems.clear();
          Get.back(); // Exit checkout screen
          Get.snackbar('Payment Success', 'Your payment was successful!');
        } else {
          Get.snackbar('Payment Failed', 'There was an issue with your payment.');
        }
      });
    }
  }

  String? validateCardNumber(String? value) {
    if (value == null || value.isEmpty || value.length != 16) {
      return 'Invalid card number';
    }
    return null;
  }

  String? validateExpiryDate(String? value) {
    if (value == null || value.isEmpty || !RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
      return 'Invalid expiry date';
    }
    return null;
  }

  String? validateCVV(String? value) {
    if (value == null || value.isEmpty || value.length != 3) {
      return 'Invalid CVV';
    }
    return null;
  }

  String? validateCardHolderName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Invalid cardholder name';
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Invalid address';
    }
    return null;
  }

  @override
  void onClose() {
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    cardHolderNameController.dispose();
    addressController.dispose();
    super.onClose();
  }
}

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    // Remove any non-numeric characters
    String newText = text.replaceAll(RegExp(r'\D'), '');

    // Format as MM/YY
    if (newText.length > 2) {
      newText = '${newText.substring(0, 2)}/${newText.substring(2)}';
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}