import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_flutter_fire/models/product_model.dart';

class ProductController extends GetxController {
  var products = <ProductModel>[].obs;

  ProductModel getProductByID(String id) {
    return products.firstWhere((product) => product.id == id);
  }

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

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }
}
