import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/cartProduct.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(child: Text('Cart is empty',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),));
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
                          Text('Total: \$${controller.total.toStringAsFixed(2)}'),
                          Text('Number of items: ${controller.itemCount}'),
                        ],
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: controller.buyItems,
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
