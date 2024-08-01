import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/cartProduct.dart';
import '../../settings/controllers/settings_controller.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  CartView({super.key});

  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: settingsController.selectedPersona.value?.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      body: controller.cartItems.isEmpty
          ? Center(
              child: Text(
                'Cart is empty',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: settingsController.selectedPersona.value?.textColor ?? Colors.black,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.cartItems.length,
                      itemBuilder: (context, index) {
                        return CartCard(
                          cartItem: controller.cartItems[index],
                          textColor: settingsController.selectedPersona.value?.textColor,
                          backgroundColor: settingsController.selectedPersona.value?.secondaryColor,
                        );
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
                            Text(
                              'Total: \$${controller.total.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: settingsController.selectedPersona.value?.textColor ?? Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Number of items: ${controller.itemCount}',
                              style: TextStyle(
                                color: settingsController.selectedPersona.value?.textColor ?? Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: controller.buyItems,
                          child: Text('Buy'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 15, 43, 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    ));
  }
}