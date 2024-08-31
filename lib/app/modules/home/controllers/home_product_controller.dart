import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_flutter_fire/models/product_model.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';

class HomeProductController extends GetxController {
  final String productID;
  Rx<ProductModel?> product = Rx<ProductModel?>(null);
  RxBool isLoading = true.obs;
  RxInt currentCarouselIndex = 0.obs;
  late CartController cartController;
  var products = <ProductModel>[].obs;
  var searchHistory = <String>[].obs;

  HomeProductController(this.productID);

  @override
  void onInit() {
    super.onInit();
    cartController = Get.put(CartController());
    fetchProductDetails();
    fetchProducts();
  }

  Future<void> fetchProductDetails() async {
    isLoading(true);
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(productID)
          .get();

      if (snapshot.exists) {
        product.value =
            ProductModel.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        Get.snackbar('Error', 'Product not found');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching product details');
    } finally {
      isLoading(false);
    }
  }

  void onPageChanged(int index) {
    currentCarouselIndex.value = index;
  }

  Future<void> fetchProductsByCategory(String categoryId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('categoryID', isEqualTo: categoryId)
          .get();

      final fetchedProducts =
          snapshot.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();
      products.assignAll(fetchedProducts);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
    }
  }

  // Fetch all products from Firestore
  Future<void> fetchProducts() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('products').get();
      final fetchedProducts =
          snapshot.docs.map((doc) => ProductModel.fromMap(doc.data())).toList();
      products.assignAll(fetchedProducts);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
    }
  }

  // Search products based on query
  List<ProductModel> searchProducts(String query) {
    query = query.trim().toLowerCase();
    return products.where((product) {
      return product.name.toLowerCase().contains(query);
    }).toList();
  }

  void addToSearchHistory(String query) {
    if (!searchHistory.contains(query)) {
      searchHistory.add(query);
    }
  }

  void clearSearchHistory() {
    searchHistory.clear();
  }

  // Get product by ID
  ProductModel? getProductByID(String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}
