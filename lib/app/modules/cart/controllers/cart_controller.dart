import 'package:get/get.dart';
import 'package:get_flutter_fire/models/cart_item.dart';
import 'package:get_flutter_fire/models/product.dart';
import 'package:get_flutter_fire/services/auth_service.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  final RxList<CartItem> _cartItems = <CartItem>[].obs;
  final GetStorage _storage = GetStorage();

  List<CartItem> get cartItems => _cartItems;

  @override
  void onInit() {
    super.onInit();
    _loadCart();
    ever(_cartItems, (_) => _saveCart());
  }

  void _loadCart() {
    final userId = AuthService.to.user?.uid ?? 'guest';
    final storedCart = _storage.read('cart_$userId');
    if (storedCart != null) {
      _cartItems.value =
          (storedCart as List).map((item) => CartItem.fromJson(item)).toList();
    }
  }

  Future<CartController> init() async {
    // Perform any initialization here
    await Future.delayed(Duration.zero); // Example delay, remove if not needed
    return this;
  }

  void _saveCart() {
    final userId = AuthService.to.user?.uid ?? 'guest';
    _storage.write(
        'cart_$userId', _cartItems.map((item) => item.toJson()).toList());
  }

  void addToCart(Product product, int quantity) {
    final existingItemIndex =
        _cartItems.indexWhere((item) => item.productId == product.id);
    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex].quantity += quantity;
    } else {
      _cartItems.add(CartItem(
        productId: product.id,
        name: product.name,
        price: product.price,
        quantity: quantity,
      ));
    }
    Get.snackbar(
      'Added to Cart',
      '${product.name} added to cart',
      snackPosition: SnackPosition.TOP,
    );
  }

  void removeItem(String productId) {
    _cartItems.removeWhere((item) => item.productId == productId);
  }

  void updateItemQuantity(String productId, int newQuantity) {
    final itemIndex =
        _cartItems.indexWhere((item) => item.productId == productId);
    if (itemIndex != -1) {
      _cartItems[itemIndex].quantity = newQuantity;
    }
  }

  void clearCart() {
    _cartItems.clear();
  }

  bool get hasItems => _cartItems.isNotEmpty;

  double get totalPrice =>
      _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  Future<void> mergeGuestCart() async {
    if (!AuthService.to.isLoggedIn) return;

    final guestCart = _storage.read('cart_guest');
    if (guestCart != null) {
      final guestItems =
          (guestCart as List).map((item) => CartItem.fromJson(item)).toList();
      for (var guestItem in guestItems) {
        addItem(guestItem);
      }
      _storage.remove('cart_guest');
    }
  }

  void addItem(CartItem item) {
    final existingItemIndex =
        _cartItems.indexWhere((i) => i.productId == item.productId);
    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex].quantity += item.quantity;
    } else {
      _cartItems.add(item);
    }
  }
}
