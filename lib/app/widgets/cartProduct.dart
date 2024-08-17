import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/models/cart_item.dart' as model; // Alias for CartItem
import '../modules/cart/controllers/cart_controller.dart';

class CartCard extends GetWidget<CartController> {
  final model.CartItem cartItem; // Use the model.CartItem

  CartCard({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.9;

    return Obx(() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: cardWidth,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                cartItem.product.productImage,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Text(
                    '\$${(cartItem.product.price * cartItem.quantity.value).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14, color: Colors.green),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => controller.removeItem(cartItem),
                ),
                Row(
                  children: [
                    IconButton(
                      style: ButtonStyle(
                        side: WidgetStateProperty.all(BorderSide(color: Colors.grey, width: 1.0)),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                      ),
                      icon: Icon(Icons.remove),
                      onPressed: () => controller.updateQuantity(cartItem, cartItem.quantity.value - 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        cartItem.quantity.value.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      style: ButtonStyle(
                        side: WidgetStateProperty.all(BorderSide(color: Colors.grey, width: 1.0)),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                      ),
                      icon: Icon(Icons.add),
                      onPressed: () => controller.updateQuantity(cartItem, cartItem.quantity.value + 1),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
