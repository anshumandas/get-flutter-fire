import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_flutter_fire/models/product.dart';
import 'package:http/http.dart' as http;

class ProductDetailController extends GetxController {
  final int productId;

  Products? product;
  final isLoading = false.obs;

  ProductDetailController(this.productId);

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    isLoading.value = true;
    try {
      final response = await http
          .get(Uri.parse('https://dummyjson.com/products/$productId'));
      if (response.statusCode == 200) {
        product = Products.fromJson(jsonDecode(response.body));
      } else {
        print('Failed to fetch product: Status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching product: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void addToCart(Products product) {
    print('Added to cart: ${product.title}');
  }
}
