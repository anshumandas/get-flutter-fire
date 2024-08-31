import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartItem {
  final String id;
  final String name;
  final double price;
  int quantity;

  CartItem({required this.id, required this.name, required this.price, this.quantity = 1});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}

class CartController extends GetxController {
  final RxList<CartItem> _items = <CartItem>[].obs;

  List<CartItem> get items => _items;

  @override
  void onInit() {
    super.onInit();
    loadCartFromPrefs();
  }

  double get total => _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void addItem(CartItem item) {
    final existingIndex = _items.indexWhere((element) => element.id == item.id);
    if (existingIndex != -1) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(item);
    }
    saveCartToPrefs();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    saveCartToPrefs();
  }

  void clear() {
    _items.clear();
    saveCartToPrefs();
  }

  Future<void> saveCartToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String cartJson = jsonEncode(_items.map((item) => item.toJson()).toList());
    await prefs.setString('cart', cartJson);
  }

  Future<void> loadCartFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString('cart');
    if (cartJson != null) {
      final List<dynamic> decodedList = jsonDecode(cartJson);
      _items.value = decodedList.map((item) => CartItem.fromJson(item)).toList();
    }
  }
}