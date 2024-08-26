import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:get_flutter_fire/app/modules/checkout/views/checkout_view.dart';
import 'package:get_flutter_fire/models/cart_item.dart' as model; // Use alias for the model CartItem
import '../../products/controllers/products_controller.dart';

class CartController extends GetxController {
  final ProductsController productsController = Get.find<ProductsController>();

  RxList<model.CartItem> cartItems = <model.CartItem>[].obs;

  double get total => cartItems.fold(0, (sum, item) => sum + (item.product.price * item.quantity.value));

  int get itemCount => cartItems.fold(0, (sum, item) => sum + item.quantity.value);

  void removeItem(model.CartItem item) {
    cartItems.remove(item);
    productsController.saveCartItems();
  }

  void updateQuantity(model.CartItem item, int quantity) {
    if (quantity > 0) {
      item.quantity.value = quantity;
      productsController.saveCartItems();
    } else {
      removeItem(item);
    }
  }

   void proceedToCheckout() {
    // Navigate to CheckoutView
    Get.to(() => CheckoutView(), binding: BindingsBuilder(() {
      Get.put(CheckoutController());
    }));
  }
}
