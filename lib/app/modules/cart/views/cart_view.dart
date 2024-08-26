import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/cartProduct.dart';
import '../../settings/controllers/settings_controller.dart';
import '../controllers/cart_controller.dart';
import '../../../../services/auth_service.dart';

class CartView extends GetView<CartController> {
  CartView({super.key});

  final SettingsController themeController = Get.find<SettingsController>();
  final AuthService authService = Get.find<AuthService>();

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
                          Obx(() => Text('Total: \$${controller.total.toStringAsFixed(2)}')),
                          Text('Number of items: ${controller.itemCount}'),
                        ],
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          if (authService.isLoggedInValue) {
                            controller.proceedToCheckout();
                          } else {
                            bool? result = await authService.checkGuestStatus();

                            if (result == true) {
                              Get.snackbar(
                                'Purchase not completed',
                                'You chose to proceed as a guest. Please sign in to complete the purchase.',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            } else if (result == false) {
                              if (authService.isLoggedInValue) {
                                controller.proceedToCheckout();
                              } else {
                                Get.snackbar(
                                  'Sign-In Required',
                                  'Please sign in to complete the purchase.',
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            }
                          }
                        },
                        child: Text('Checkout'),
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
