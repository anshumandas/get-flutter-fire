import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetailsController extends GetxController {
  final String productId;
  final String apiUrl = 'https://anubhav-website.onrender.com/api/product-details';
  var productDetails = {}.obs;
  var isLoading = true.obs;

  ProductDetailsController(this.productId);

  @override
  void onInit() {
    super.onInit();
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode({'productId': productId}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        productDetails.value = responseData['data'];
      } else {
        Get.snackbar('Error', responseData['message'] ?? 'Failed to fetch product details');
      }
    } else {
      Get.snackbar('Error', 'Failed to fetch product details');
    }
    isLoading.value = false;
  }

  @override
  void onClose() {
    Get.log('ProductDetailsController close with id: $productId');
    super.onClose();
  }
}
