import 'package:get/get.dart';
import 'package:get_flutter_fire/models/product.dart';
import '../../../../services/auth_service.dart';

class CartController extends GetxController {
  final RxList<Product> cartItems = <Product>[].obs;
  final RxDouble totalPrice = 0.0.obs;

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

  void increment() => totalPrice.value++;

  Future<void> signInAnonymously() async {
    await AuthService.to.signInAnonymously();
    update();
  }

  Future<void> convertAnonymousAccount(String email, String password) async {
    await AuthService.to.convertAnonymousAccount(email, password);
  }

  Future<void> addItemToCart(Product product) async {
    if (AuthService.to.user == null) {
      // If the user is not signed in, sign them in anonymously
      await signInAnonymously();
    }
    cartItems.add(product);
    totalPrice.value += product.price;
    print("Product added to cart: ${product.name}");
    update();
  }

  Future<void> removeItemFromCart(Product product) async {
    cartItems.remove(product);
    totalPrice.value -= product.price;
    print("Product removed from cart: ${product.name}");
    update();
  }

  Future<void> checkout() async {
    if (AuthService.to.user == null) {
      // If the user is not signed in, sign them in anonymously
      await signInAnonymously();
    }
    // Proceed with the checkout process
    print("Checkout process initiated");
    update();
  }

  void calculateTotalPrice() {
    totalPrice.value = cartItems.fold(0, (sum, item) => sum + item.price);
  }

  void clearCart() {
    cartItems.clear();
    calculateTotalPrice();
  }
}
