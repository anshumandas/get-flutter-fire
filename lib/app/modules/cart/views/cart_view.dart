import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../checkout/views/checkout_view.dart';
import '../controllers/cart_controller.dart'; // Adjust the import based on your file structure

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              controller.clearCart();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(child: Text('No items in the cart'));
        } else {
          return ListView.builder(
            itemCount: controller.cartItems.length,
            itemBuilder: (context, index) {
              final item = controller.cartItems[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    controller.removeFromCart(item.id);
                  },
                ),
              );
            },
          );
        }
      }),
      bottomNavigationBar: Obx(() {
        final totalPrice = controller.getTotalPrice();
        return BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Debug log for navigation
                    Get.log('Navigating to Checkout');
                    Get.to(() => CheckoutView());
                  },
                  child: const Text('Checkout'),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
