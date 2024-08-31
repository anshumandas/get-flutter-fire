import 'package:get/get.dart';
import 'package:get_flutter_fire/models/products_admin.dart';

class CartController extends GetxController {
  var cartItems = <Product, int>{}.obs; // Map of product to quantity

  void addToCart(Product product, int quantity) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + quantity;
    } else {
      cartItems[product] = quantity;
    }
    update();
  }

  void removeFromCart(Product product) {
    if (cartItems.containsKey(product)) {
      if (cartItems[product]! > 1) {
        cartItems[product] = cartItems[product]! - 1; // Decrease quantity
      } else {
        cartItems.remove(product); // Remove if quantity is 1 or less
      }
      update();
    }
  }

  double get totalPrice => cartItems.entries
      .map((entry) => entry.key.price! * entry.value)
      .fold(0, (sum, price) => sum + price);
}
