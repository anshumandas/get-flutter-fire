import 'package:get/get.dart';
import '../../../../models/product_details.dart';

class CartController extends GetxController {
  // List to store cart items
  var cartItems = <Product>[].obs;

  // Method to add a product to the cart
  void addProductToCart(Product product) {
    cartItems.add(product);
    Get.snackbar('Added to Cart', '${product.name} has been added to your cart.', snackPosition: SnackPosition.BOTTOM);
  }

  // Method to remove a product from the cart
  void removeProductFromCart(Product product) {
    cartItems.remove(product);
    Get.snackbar('Removed from Cart', '${product.name} has been removed from your cart.', snackPosition: SnackPosition.BOTTOM);
  }

  // Method to clear the cart
  void clearCart() {
    cartItems.clear();
    Get.snackbar('Cart Cleared', 'All items have been removed from your cart.', snackPosition: SnackPosition.BOTTOM);
  }

  // Get the total price of items in the cart
  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
