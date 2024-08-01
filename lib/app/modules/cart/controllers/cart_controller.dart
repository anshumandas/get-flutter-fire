import 'package:get/get.dart';
<<<<<<< HEAD
import '../../products/controllers/products_controller.dart';

class CartController extends GetxController {
  final ProductsController productsController = Get.find<ProductsController>();

  RxList<CartItem> get cartItems => productsController.cartItems;

  double get total => cartItems.fold(0, (sum, item) => sum + (item.product.price * item.quantity.value));

  int get itemCount => cartItems.fold(0, (sum, item) => sum + item.quantity.value);

  void removeItem(CartItem item) {
    cartItems.remove(item);
    productsController.saveCartItems();
  }

  void updateQuantity(CartItem item, int quantity) {
    if (quantity > 0) {
      item.quantity.value = quantity;
      productsController.saveCartItems();
    } else {
      removeItem(item);
    }
  }

  void buyItems() {
    Get.snackbar('Success', 'Items purchased successfully!');
    cartItems.clear();
    productsController.saveCartItems();
  }
}
=======

class CartController extends GetxController {
  //TODO: Implement CartController

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
}
>>>>>>> origin/main
