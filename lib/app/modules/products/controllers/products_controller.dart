import 'package:get/get.dart';
import 'package:get_flutter_fire/models/product.dart';
import 'package:get_flutter_fire/services/firebase_service.dart';

class ProductsController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  final RxList<Product> products = <Product>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    try {
      products.value = await _firebaseService.getProducts();
      print('Fetched ${products.length} products');
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void addToCart(Product product) {
    // Implement add to cart functionality
    print('Added ${product.name} to cart');
  }
}
