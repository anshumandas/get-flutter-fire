import 'dart:async';

import 'package:get/get.dart';

class DashboardController extends GetxController {
  final now = DateTime.now().obs;

  // Product lists
  final RxList<Map<String, String>> products = <Map<String, String>>[].obs;
  final RxList<Map<String, String>> trendingProducts =
      <Map<String, String>>[].obs;

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
      {
        'name': 'Womens Perfume Collection',
        'image': 'assets/images/1.png',
        'price': '\₹2000'
      },
      {
        'name': 'Mens Perfume Collection',
        'image': 'assets/images/2.png',
        'price': '\₹4000'
      },
      {'name': 'Unisex', 'image': 'assets/images/3.png', 'price': '\₹5600'},
      {
        'name': 'Luxury perfume Collection',
        'image': 'assets/images/4.png',
        'price': '\₹7600'
      },
    ]);
  }

  void fetchTrendingProducts() {
    trendingProducts.assignAll([
      {
        'name': 'Trending Perfume',
        'image': 'assets/images/1.png',
        'price': '\₹2000'
      },
      {
        'name': 'Trending for Men',
        'image': 'assets/images/2.png',
        'price': '\₹5600'
      },
    ]);
  }
}
