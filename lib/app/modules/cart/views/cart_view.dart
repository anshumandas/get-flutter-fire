import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        if (!AuthService.to.isLoggedIn) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    'Please log in or continue as a guest to view your cart.'),
                ElevatedButton(
                  onPressed: () async {
                    bool success = await AuthService.to.signInAnonymously();
                    if (success) {
                      Get.snackbar('Success', 'Signed in as guest');
                    }
                  },
                  child: const Text('Continue as Guest'),
                ),
                ElevatedButton(
                  onPressed: () => Get.rootDelegate.toNamed(Screen.LOGIN.route),
                  child: const Text('Log In'),
                ),
              ],
            ),
          );
        }
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
                    onPressed: controller.hasItems
                        ? () {
                            // TODO: Implement checkout functionality
                            Get.snackbar(
                                'Checkout', 'Proceeding to checkout...');
                          }
                        : null,
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
