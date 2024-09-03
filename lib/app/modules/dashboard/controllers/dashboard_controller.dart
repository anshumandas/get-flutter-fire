import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_flutter_fire/services/auth_service.dart';
import 'package:get_flutter_fire/models/product.dart';
import 'package:get_flutter_fire/models/category.dart';
import 'dart:math';

class DashboardController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxList<Product> featuredProducts = <Product>[].obs;
  final RxList<Product> recentlyViewedProducts = <Product>[].obs;
  final RxList<Category> featuredCategories = <Category>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    isLoading.value = true;
    try {
      // Fetch categories
      print("Fetching categories...");
      QuerySnapshot categoriesSnapshot =
          await _firestore.collection('categories').get();
      print("Categories fetched: ${categoriesSnapshot.docs.length}");

      List<Category> allCategories = categoriesSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print("Category data: $data");
        return Category.fromMap(data, doc.id);
      }).toList();

      print("All categories: ${allCategories.length}");

      // Randomly select featured categories
      featuredCategories.value = _getRandomItems(allCategories, 5);
      print("Featured categories: ${featuredCategories.length}");
      featuredCategories.forEach((category) {
        print(
            "Featured category: ${category.name}, Image: ${category.imageUrl}");
      });

      // Fetch products (keeping this part as is)
      QuerySnapshot productsSnapshot =
          await _firestore.collection('products').get();
      List<Product> allProducts = productsSnapshot.docs
          .map((doc) =>
              Product.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      featuredProducts.value = _getRandomItems(allProducts, 5);

      // Fetch recently viewed products (if user is logged in)
      if (AuthService.to.isLoggedIn) {
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(AuthService.to.user!.uid)
            .get();
        List<String> recentProductIds =
            List<String>.from(userDoc['recentlyViewed'] ?? []);
        recentlyViewedProducts.value = allProducts
            .where((product) => recentProductIds.contains(product.id))
            .toList();
      }
    } catch (e) {
      print('Error fetching dashboard data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<T> _getRandomItems<T>(List<T> items, int count) {
    if (items.length <= count) return items;

    List<T> randomItems = [];
    List<int> indices = List.generate(items.length, (index) => index);
    Random random = Random();

    for (int i = 0; i < count; i++) {
      int randomIndex = random.nextInt(indices.length);
      randomItems.add(items[indices[randomIndex]]);
      indices.removeAt(randomIndex);
    }

    return randomItems;
  }
}
