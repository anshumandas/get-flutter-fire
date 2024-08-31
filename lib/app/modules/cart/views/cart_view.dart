import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/cartProduct.dart';
//import '../../settings/controllers/settings_controller.dart';
import '../controllers/cart_controller.dart';
import '../../../../services/auth_service.dart'; // Import your AuthService

class CartView extends GetView<CartController> {
  CartView({super.key});

  //final SettingsController themeController = Get.find<SettingsController>();
  final AuthService authService = Get.find<AuthService>(); // Get the AuthService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(
            child: Text(
              'Cart is empty',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.cartItems.length,
                    itemBuilder: (context, index) {
                      return CartCard(cartItem: controller.cartItems[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total: \₹${controller.total.toStringAsFixed(2)}'),
                          Text('Number of items: ${controller.itemCount}'),
                        ],
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          if (authService.isLoggedInValue) {
                            // User is logged in, proceed with the purchase
                            controller.buyItems();
                          } else {
                            // User is not logged in, show sign-in dialog
                            bool? result = await authService.guest();

                            if (result == true) {
                              // User chose to proceed as a guest, do nothing (don't buy items)
                              Get.snackbar(
                                'Purchase not completed',
                                'You chose to proceed as a guest. Please sign in to complete the purchase.',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            } else if (result == false) {
                              // User chose to sign in now, wait for sign in to complete
                              if (authService.isLoggedInValue) {
                                // If the user successfully signs in, proceed with the purchase
                                controller.buyItems();
                              } else {
                                // User canceled or failed sign-in, no action needed
                                Get.snackbar(
                                  'Sign-In Required',
                                  'Please sign in to complete the purchase.',
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            }
                          }
                        },
                        child: Text('Buy'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
