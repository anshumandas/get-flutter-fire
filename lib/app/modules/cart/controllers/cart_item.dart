import 'package:flutter/cupertino.dart';

import '../../../../models/product.dart';

class CartItem {
  final String id; // Add ID
  final String name;
  final double price;
  final IconData icon; // Use IconData instead of imagePath
  final Product product;
  final String? size;
  int quantity;

  CartItem({
    required this.id, // Add required parameter for id
    required this.name,
    required this.price,
    required this.icon, // Update this to IconData
    this.quantity =1,
    this.size,
    required this.product,
  });
}
