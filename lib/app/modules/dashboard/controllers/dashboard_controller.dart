import 'dart:async';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final now = DateTime.now().obs;

  // Product lists
  final RxList<Map<String, String>> products = <Map<String, String>>[].obs;
  final RxList<Map<String, String>> trendingProducts =
      <Map<String, String>>[].obs;
  final RxList<Map<String, String>> luxuryPerfumes = <Map<String, String>>[].obs;
  final RxList<Map<String, String>> darkPerfumes = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchTrendingProducts();
    fetchLuxuryPerfumes();
    fetchDarkPerfumes();
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
        'name': 'Women\'s Perfume Collection',
        'image': 'assets/images/1.png',
        'price': '\₹2000',
      },
      {
        'name': 'Men\'s Perfume Collection',
        'image': 'assets/images/2.png',
        'price': '\₹4000',
      },
      {
        'name': 'Unisex',
        'image': 'assets/images/3.png',
        'price': '\₹5600',
      },
      {
        'name': 'Luxury Perfume Collection',
        'image': 'assets/images/4.png',
        'price': '\₹7600',
      },
    ]);
  }

  void fetchTrendingProducts() {
    trendingProducts.assignAll([
      {
        'name': 'Eternal Blossom',
        'image': 'assets/images/image3.jpg',
        'price': '\₹2000',
      },
      {
        'name': 'Crimson Desire',
        'image': 'assets/images/image2.jpg',
        'price': '\₹5600',
      },
    ]);
  }

  void fetchLuxuryPerfumes() {
    luxuryPerfumes.assignAll([
      {
        'name': 'Luxury Night Perfume',
        'image': 'assets/images/luxury1.jpg',
        'price': '\₹3000',
      },
      {
        'name': 'Elegant Women\'s Perfume',
        'image': 'assets/images/luxury2.jpg',
        'price': '\₹7600',
      },
    ]);
  }

  void fetchDarkPerfumes() {
    darkPerfumes.assignAll([
      {
        'name': 'Dark Mystique',
        'image': 'assets/images/dark1.jpg',
        'price': '\₹3500',
      },
      {
        'name': 'Midnight Essence',
        'image': 'assets/images/dark2.jpg',
        'price': '\₹4000',
      },
      {
        'name': 'Noir Elegance',
        'image': 'assets/images/dark3.jpg',
        'price': '\₹4500',
      },
    ]);
  }
}
