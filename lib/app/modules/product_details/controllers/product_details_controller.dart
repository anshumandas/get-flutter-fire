import 'dart:convert';
import 'package:flutter/services.dart'; // For rootBundle
import 'package:get/get.dart';
import '../../../../models/product.dart'; // Ensure this path is correct

class ProductDetailController extends GetxController {
  final int productId;
  RxBool isLoading = false.obs;
  Rx<Products?> product = Rx<Products?>(null);

  ProductDetailController(this.productId);

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    isLoading.value = true;
    try {
      final String response = await rootBundle.loadString('assets/headphones.json');
      final Map<String, dynamic> data = jsonDecode(response);
      final Product productData = Product.fromJson(data);

      // Use `firstWhere` to find the product, and handle the case when it is not found
      final Products? foundProduct = productData.products?.firstWhere(
              (p) => p.id == productId,
          orElse: () => Products() // Return a default instance of Products if not found
      );

      // Update product observable
      if (foundProduct != null && foundProduct.id == productId) {
        product.value = foundProduct;
      } else {
        // Handle the case where the product is not found
        print('Product with ID $productId not found');
        product.value = null; // Set to null if not found
      }
    } catch (e) {
      print('Error fetching product: $e');
      product.value = null; // Handle error case
    } finally {
      isLoading.value = false;
    }
  }
}
