import 'package:get/get.dart';
import 'cart_item.dart'; // Adjust the import based on your file structure

class CartController extends GetxController {
  // Observable list of cart items
  var cartItems = <CartItem>[].obs;

  // Method to add an item to the cart
  void addToCart(CartItem item) {
    cartItems.add(item);
  }

  // Method to remove an item from the cart by ID
  void removeFromCart(String id) {
    cartItems.removeWhere((item) => item.id == id);
  }

  // Method to clear all items from the cart
  void clearCart() {
    cartItems.clear();
  }

  // Method to calculate the total price of items in the cart
  double getTotalPrice() {
    return cartItems.fold(0.0, (sum, item) => sum + item.price);
  }
}
