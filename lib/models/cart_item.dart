import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  String id;
  String name;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.quantity,
  });

  factory CartItem.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CartItem(
      id: doc.id,
      name: data['name'] ?? '',
      quantity: data['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }
}
