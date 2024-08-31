import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cart/controller/cart_controller.dart';
import '../controller/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Obx(() => controller.isProcessing.value
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                ...cartController.items.map((item) => ListTile(
                      title: Text(item.name),
                      subtitle: Text('${item.quantity} x \$${item.price.toStringAsFixed(2)}'),
                      trailing: Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                    )),
                Divider(),
                ListTile(
                  title: Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: Text(
                    '\$${cartController.total.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: controller.isProcessing.value ? null : controller.checkout,
          child: Text('Place Order'),
        ),
      ),
    );
  }
}
