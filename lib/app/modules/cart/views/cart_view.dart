import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_flutter_fire/app/routes/app_pages.dart';
import '../../../widgets/screen_widget.dart';
import '../../../../services/auth_service.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      return Scaffold(
        body: Obx(() {
          if (cartController.cartItems.isEmpty) {
            return const Center(child: Text('No items in cart'));
          }
          return ListView.builder(
            itemCount: cartController.cartItems.length,
            itemBuilder: (context, index) {
              var product = cartController.cartItems.keys.toList()[index];
              var quantity = cartController.cartItems[product]!;
              return ListTile(
                title: Text(product.name ?? 'Product'),
                subtitle: Text('Quantity: $quantity'),
                trailing: Text('Rs. ${product.price! * quantity}'),
                onTap: () {
                  // Navigate to product description or allow editing quantity
                },
              );
            },
          );
        }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: Rs. ${cartController.totalPrice}'),
              ElevatedButton(
                onPressed: () {
                  // Proceed to payment or checkout
                },
                child: const Text('Proceed to Payment'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
