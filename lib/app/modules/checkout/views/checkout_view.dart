import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/checkout_controller.dart';
import '../../cart/controllers/cart_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Checkout',
          style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
          color: Colors.white,
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartController.cartItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Image.asset(
                        item.imageAsset,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.name),
                      subtitle: Text('Price: Rs ${item.price}'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Total: Rs ${cartController.totalPrice}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Get.find<CheckoutController>().processCheckout();
              },
              child: Text('Complete Booking'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Colors.pinkAccent[100],
                textStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                 ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
