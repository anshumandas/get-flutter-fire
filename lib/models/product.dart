import 'package:flutter/cupertino.dart';

class Product {
  final String id; // Add ID
  final String name;
  final double price;
  final IconData icon; // Use IconData instead of imagePath
  final DateTime date;
  final List<String>? sizes; // Make sizes optional if not all products have sizes
  final String description; // Field for description

  Product({
    required this.id, // Add required parameter for id
    required this.name,
    required this.price,
    required this.icon, // Update this to IconData
    required this.date,
    required this.description,
    this.sizes,
  });
}
