import 'package:get/get.dart';
import '../../cart/controllers/cart_controller.dart';

class CheckoutController extends GetxController {
  final CartController cartController = Get.find<CartController>();

  void processCheckout() {

    // For demonstration, we're just clearing the cart
    cartController.clearCart();

    // Show a confirmation message
    Get.snackbar('Success', 'Your Booking is successful!', snackPosition: SnackPosition.BOTTOM);

    // Navigate to a different page or home screen after checkout
    Get.offAllNamed('/home');
  }
}