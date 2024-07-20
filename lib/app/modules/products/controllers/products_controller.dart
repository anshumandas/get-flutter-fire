import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../models/product.dart';

class ProductsController extends GetxController {
  final products = <Product>[].obs;
  final apiUrl = 'https://anubhav-website.onrender.com/api/get-product';

  @override
  void onInit() {
    super.onInit();
    fetchProductsFromApi();
  }

  Future<void> fetchProductsFromApi() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          products.value = List<Product>.from(
            data['data'].map((product) => Product.fromJson(product)),
          );
        } else {
          print('Failed to load data: ${response.statusCode}');
        }
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to fetch products');
    }
  }

  @override
  void onClose() {
    Get.printInfo(info: 'Products: onClose');
    super.onClose();
  }
}
