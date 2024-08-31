import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../cart/controller/cart_controller.dart';

class CheckoutController extends GetxController {
  final CartController cartController = Get.find();
  final RxBool isProcessing = false.obs;

  Future<void> checkout() async {
    isProcessing.value = true;
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.isAnonymous) {
        bool? result = await Get.dialog<bool>(
          AlertDialog(
            title: Text('Create an Account?'),
            content: Text('Would you like to create an account to track your order?'),
            actions: [
              TextButton(
                child: Text('No, thanks'),
                onPressed: () {
                  Get.back(result: false);
                },
              ),
              TextButton(
                child: Text('Create Account'),
                onPressed: () {
                  Get.back(result: true);
                },
              ),
            ],
          ),
        );

        if (result == true) {
          await Get.toNamed('/Signup', arguments: {'wasGuest': true});
          user = FirebaseAuth.instance.currentUser;
          if (user != null && !user.isAnonymous) {
            Get.offNamed('/cart');  // Navigate to cart page after successful signup
          } else {
            Get.snackbar('Info', 'Signup cancelled. Continuing as guest.');
            _completeCheckout();
          }
        } else {
          _completeCheckout();
        }
      } else {
        _completeCheckout();
      }
    } catch (e) {
      Get.snackbar('Error', 'Checkout process interrupted: ${e.toString()}');
    } finally {
      isProcessing.value = false;
    }
  }

  void _completeCheckout() {
    // Simulate payment processing
    Future.delayed(Duration(seconds: 2), () {
      cartController.clear();
      Get.snackbar('Success', 'Order placed successfully');
      Get.offAllNamed('/home');
    });
  }
}