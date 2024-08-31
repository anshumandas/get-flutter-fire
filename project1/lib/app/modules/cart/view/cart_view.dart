import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/cart_controller.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Obx(() => ListView.builder(
        itemCount: controller.items.length,
        itemBuilder: (context, index) {
          final item = controller.items[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text('${item.price} x ${item.quantity}'),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () => controller.removeItem(item.id),
            ),
          );
        },
      )),
      bottomNavigationBar: Obx(() => BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: \$${controller.total.toStringAsFixed(2)}'),
              ElevatedButton(
                onPressed: () => Get.toNamed('/checkout'),
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      )),
    );
  }
}