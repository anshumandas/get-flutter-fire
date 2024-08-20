import 'dart:async';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final now = DateTime.now().obs;

  // Clothing products and trending products lists
  final RxList<Map<String, String>> products = <Map<String, String>>[].obs;
  final RxList<Map<String, String>> trendingProducts = <Map<String, String>>[].obs;

  // Filters
  final RxList<String> filters = ['All', 'Male', 'Female', 'Unisex'].obs;
  final RxString selectedFilter = 'All'.obs;

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
      {'name': 'T-Shirt', 'image': 'https://i.ibb.co/9wh4mFv/t-shirt.jpg', 'price': '\$20', 'category': 'Male'},
      {'name': 'Jeans', 'image': 'https://i.ibb.co/ZK6vYDx/Jeans.jpg', 'price': '\$40', 'category': 'Male'},
      {'name': 'women Jeans', 'image': 'https://i.ibb.co/V3CBYKz/Jeans_F.jpg', 'price': '\$60', 'category': 'Female'},
      {'name': 'Sneakers', 'image': 'https://i.ibb.co/XkVQNJp/Sneakers.jpg', 'price': '\$80', 'category': 'Unisex'},
      {'name': 'Dress', 'image': 'https://i.ibb.co/DDpVWHm/Dress.jpg', 'price': '\$50', 'category': 'Female'},
      {'name': 'Sunglasses', 'image': 'https://i.ibb.co/XttT0xh/Sunglasses.jpg', 'price': '\$25', 'category': 'Unisex'},
    ]);
  }

  void fetchTrendingProducts() {
    trendingProducts.assignAll([
      {'name': 'Trending T-Shirt', 'image': 'https://i.ibb.co/9wh4mFv/t-shirt.jpg', 'price': '\$30'},
      {'name': 'Trending Dress', 'image': 'https://i.ibb.co/DDpVWHm/Dress.jpg', 'price': '\$65'},
    ]);
  }

  List<Map<String, String>> get filteredProducts {
    if (selectedFilter.value == 'All') {
      return products;
    } else {
      return products.where((product) => product['category'] == selectedFilter.value).toList();
    }
  }

  void updateFilter(String? filter) {
    selectedFilter.value = filter ?? 'All';
  }
}
