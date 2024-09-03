import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_flutter_fire/models/product.dart';

class ProductsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<Product> products = <Product>[].obs;
  final RxBool isLoading = true.obs;
  final RxString selectedCategoryId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    try {
      print(
          'Fetching products. Selected category: ${selectedCategoryId.value}');
      QuerySnapshot querySnapshot;
      if (selectedCategoryId.value.isEmpty) {
        querySnapshot = await _firestore.collection('products').get();
      } else {
        querySnapshot = await _firestore
            .collection('products')
            .where('categoryId', isEqualTo: selectedCategoryId.value)
            .get();
      }
      print('Fetched ${querySnapshot.docs.length} product documents');

      products.value = querySnapshot.docs.map((doc) {
        print('Processing product document: ${doc.id}');
        print('Product data: ${doc.data()}');
        return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      print('Processed ${products.length} products');
      products.forEach((product) {
        print(
            'Product: ${product.id} - ${product.name} - Category: ${product.categoryId}');
      });
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void setSelectedCategory(String categoryId) {
    print('Setting selected category: $categoryId');
    selectedCategoryId.value = categoryId;
    fetchProducts();
  }

  void clearCategoryFilter() {
    print('Clearing category filter');
    selectedCategoryId.value = '';
    fetchProducts();
  }
}
