import 'package:get/get.dart';
import '../../../../models/product.dart';
import 'package:flutter/material.dart';

class ProductsController extends GetxController {
  final products = <Product>[].obs;

  // Method to add a demo product to the list
  void loadDemoProductsFromSomeWhere() {
    final demoProducts = [
      Product(name: 'T-shirt', id: '1', icon: Icons.shopping_bag, price: 19.99, date: DateTime.now(), description: 'Comfortable cotton t-shirt'),
      Product(name: 'Pages', id: '2', icon: Icons.pages, price: 39.99, date: DateTime.now(), description: 'Pages notebook for writing'),
      Product(name: 'Sports', id: '3', icon: Icons.sports, price: 29.99, date: DateTime.now(), description: 'Various sports equipment'),
      Product(name: 'Jacket', id: '4', icon: Icons.watch, price: 59.99, date: DateTime.now(), description: 'Warm winter jacket'),
      Product(name: 'Handwash', id: '5', icon: Icons.sanitizer, price: 49.99, date: DateTime.now(), description: 'Antibacterial hand wash'),
    ];

    products.addAll(demoProducts);
  }

  // Method to add a single product dynamically
  void addProduct(Product product) {
    products.add(product);
  }

  // Method to remove a product by ID
  void removeProduct(String id) {
    products.removeWhere((product) => product.id == id);
  }

  @override
  void onReady() {
    super.onReady();
    loadDemoProductsFromSomeWhere();
  }

  @override
  void onClose() {
    Get.printInfo(info: 'ProductsController: onClose');
    super.onClose();
  }
}
