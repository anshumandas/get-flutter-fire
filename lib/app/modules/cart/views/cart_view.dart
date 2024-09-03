import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/routes/app_pages.dart';
import '../../../widgets/screen_widget.dart';
import '../../../../services/auth_service.dart';
import '../controllers/cart_controller.dart';
import '../../../../models/screens.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      screen: Screen.CART,
      appBar: AppBar(
        title: Text('${AuthService.to.userName}\'s Cart'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(child: Text('Your cart is empty'));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  final item = controller.cartItems[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('Quantity: ${item.quantity}'),
                    trailing: Text(
                        '\Rs ${(item.price * item.quantity).toStringAsFixed(2)}'),
                    leading: IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () => controller.removeItem(item.productId),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \Rs ${controller.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (AuthService.to.isAnonymous) {
                        Get.dialog(
                          AlertDialog(
                            title: Text('Login Required'),
                            content:
                                Text('Please login to proceed with checkout.'),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () => Get.back(),
                              ),
                              ElevatedButton(
                                child: Text('Login'),
                                onPressed: () {
                                  Get.back();
                                  Get.toNamed(Routes.LOGIN);
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        // Proceed with checkout
                        Get.toNamed(Routes.CHECKOUT);
                      }
                    },
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
