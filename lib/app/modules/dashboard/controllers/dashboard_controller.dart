import 'dart:async';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final now = DateTime.now().obs;

  // Clothing products and trending products lists
  final RxList<Map<String, String>> products = <Map<String, String>>[].obs;
  final RxList<Map<String, String>> trendingProducts = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchTrendingProducts();
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        now.value = DateTime.now();
      },
    );
  }

  void fetchProducts() {
    products.assignAll([
      {'name': 'T-Shirt', 'image': 'https://via.placeholder.com/150x150', 'price': '\$20'},
      {'name': 'Jeans', 'image': 'https://via.placeholder.com/150x150', 'price': '\$40'},
      {'name': 'Jacket', 'image': 'https://via.placeholder.com/150x150', 'price': '\$60'},
      {'name': 'Sneakers', 'image': 'https://via.placeholder.com/150x150', 'price': '\$80'},
      {'name': 'Dress', 'image': 'https://via.placeholder.com/150x150', 'price': '\$50'},
      {'name': 'Sunglasses', 'image': 'https://via.placeholder.com/150x150', 'price': '\$25'},
    ]);
  }

  void fetchTrendingProducts() {
    trendingProducts.assignAll([
      {'name': 'Trending Jacket', 'image': 'https://via.placeholder.com/200x200', 'price': '\$75'},
      {'name': 'Trending Sneakers', 'image': 'https://via.placeholder.com/200x200', 'price': '\$90'},
      {'name': 'Trending T-Shirt', 'image': 'https://via.placeholder.com/200x200', 'price': '\$30'},
      {'name': 'Trending Dress', 'image': 'https://via.placeholder.com/200x200', 'price': '\$65'},
      {'name': 'Trending Sunglasses', 'image': 'https://via.placeholder.com/200x200', 'price': '\$35'},
    ]);
  }
}
