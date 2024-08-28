//lib/app/modules/products/controllers/products_controller.dart
import 'dart:convert';
import 'package:flutter/services.dart'; // For rootBundle
import 'package:get/get.dart';
import '../../../../models/product.dart'; // Ensure this path is correct

class ProductsController extends GetxController {
  final _products = RxList<Products>([]);

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final String response = await rootBundle.loadString('assets/headphones.json');
      final Map<String, dynamic> data = jsonDecode(response);
      final Product productData = Product.fromJson(data);
      _products.value = productData.products ?? [];
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  List<Products> get products => _products;
}
