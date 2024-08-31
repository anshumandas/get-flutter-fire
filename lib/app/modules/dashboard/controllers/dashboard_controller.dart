import 'dart:async';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final now = DateTime.now().obs;

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
      {'name': 'Smartphone', 'image': 'https://media.designrush.com/tinymce_images/341786/conversions/elin-content.jpg'},
      {'name': 'Laptop', 'image': 'https://media.designrush.com/tinymce_images/341786/conversions/elin-content.jpg'},
      {'name': 'Headphones', 'image': 'https://media.designrush.com/tinymce_images/341786/conversions/elin-content.jpg'},
      {'name': 'Smartwatch', 'image': 'https://media.designrush.com/tinymce_images/341786/conversions/elin-content.jpg'},
      {'name': 'Camera', 'image': 'https://media.designrush.com/tinymce_images/341786/conversions/elin-content.jpg'},
      {'name': 'Speaker', 'image': 'https://media.designrush.com/tinymce_images/341786/conversions/elin-content.jpg'},
    ]);
  }

  void fetchTrendingProducts() {
    trendingProducts.assignAll([
      {'name': 'Trending Product 1', 'image': 'https://ecommercephotographyindia.com/info/wp-content/uploads/2021/09/product-lifestyle-photography.jpg'},
      {'name': 'Trending Product 2', 'image': 'https://ecommercephotographyindia.com/info/wp-content/uploads/2021/09/product-lifestyle-photography.jpg'},
      {'name': 'Trending Product 3', 'image': 'https://ecommercephotographyindia.com/info/wp-content/uploads/2021/09/product-lifestyle-photography.jpg'},
      {'name': 'Trending Product 4', 'image': 'https://ecommercephotographyindia.com/info/wp-content/uploads/2021/09/product-lifestyle-photography.jpg'},
      {'name': 'Trending Product 5', 'image': 'https://ecommercephotographyindia.com/info/wp-content/uploads/2021/09/product-lifestyle-photography.jpg'},
    ]);
  }
}
