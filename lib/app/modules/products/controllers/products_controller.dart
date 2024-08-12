import 'dart:convert';

import 'package:get/get.dart';
import '../../../../models/product.dart';
import 'package:http/http.dart' as http;

class ProductsController extends GetxController {
  final _products = RxList<Products>([]);
  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<Products> products = List<Products>.from(
          data['products'].map((item) => Products.fromJson(item)));
      _products.value = products;
    } else {
      // Handle errors
    }
  }

  List<Products> get products => _products;
}
