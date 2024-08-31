import 'package:get/get.dart';
import '../../cart/controllers/cart_controller.dart';

class CheckoutController extends GetxController {
  final cartController = Get.find<CartController>();
  final count = 0.obs;

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

  void increment() => count.value++;

  double get totalPrice => cartController.totalPrice.value;

  void checkout() {
    if (cartController.cartItems.isEmpty) {
      print("Cart is empty. Add items before checking out.");
      return;
    }
    // Placeholder for the payment process logic
    print(
        "Checkout initiated with total price: \$${totalPrice.toStringAsFixed(2)}");

    // Clear the cart after successful checkout
    cartController.clearCart();
  }
}
