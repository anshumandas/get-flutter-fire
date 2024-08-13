import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../models/cart_item.dart';

class CartController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();

    // Add a dummy item for demonstration purposes
    final dummyItem = CartItem(
      id: 'dummy-id',
      name: 'Dummy Item',
      quantity: 1,
    );
    cartItems.add(dummyItem);
  }

  Future<void> fetchCartItems() async {
    const userId = 'your-user-id'; // Replace with the actual user ID
    final snapshot = await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .get();

    final items = snapshot.docs
        .map((doc) => CartItem.fromDocument(doc))
        .toList();

    cartItems.assignAll(items);
  }

  Future<void> addCartItem(CartItem item) async {
    const userId = 'your-user-id'; // Replace with the actual user ID
    await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .add(item.toMap());

    fetchCartItems();
  }

  Future<void> removeCartItem(String itemId) async {
    const userId = 'your-user-id'; // Replace with the actual user ID
    await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .doc(itemId)
        .delete();

    fetchCartItems();
  }

  Future<void> updateCartItem(CartItem item) async {
    const userId = 'your-user-id'; // Replace with the actual user ID
    await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .doc(item.id)
        .update(item.toMap());

    fetchCartItems();
  }
}
