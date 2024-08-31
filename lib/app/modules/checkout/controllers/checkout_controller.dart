import 'package:get/get.dart';
import '../../cart/controllers/cart_controller.dart'; // Ensure this import is correct

class CheckoutController extends GetxController {
  final cartController = Get.find<CartController>();

  double get totalAmount {
    return cartController.cartItems.fold<double>(
      0.0,
          (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  void proceedToPayment() {
    // Implement payment logic here
    // For now, just print a message
    Get.snackbar('Checkout', 'Proceeding to payment.');
  }

  @override
  void onClose() {
    Get.printInfo(info: 'CheckoutController: onClose');
    super.onClose();
  }
}
