import 'package:get/get.dart';
import 'package:get_flutter_fire/models/product_category.dart';
import 'package:get_flutter_fire/models/products_admin.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference prodCollection;
  late CollectionReference categoryCollection;
  List<Product> products = [];
  List<Product> productsInUI = [];
  List<ProductCategory> categories = [];
  @override
  Future<void> onInit() async {
    prodCollection = firestore.collection('products');
    categoryCollection = firestore.collection('category');
    await fetchCategory();
    await fetchProducts();
    super.onInit();
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await prodCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrievedProducts);
      productsInUI.clear();
      productsInUI.assignAll(products);
    } on Exception catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally {
      update();
    }
  }

  fetchCategory() async {
    try {
      QuerySnapshot categorySnapshot = await categoryCollection.get();
      final List<ProductCategory> retrievedCategories = categorySnapshot.docs
          .map((doc) =>
              ProductCategory.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      categories.clear();
      categories.assignAll(retrievedCategories);
    } on Exception catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally {
      update();
    }
  }

  filterByCategory(String category) {
    productsInUI.clear();
    productsInUI =
        products.where((product) => product.category == category).toList();
    update();
  }

  filterByBrand(List<String> brands) {
    if (brands.isEmpty) {
      productsInUI = products;
    } else {
      productsInUI =
          products.where((product) => brands.contains(product.brand)).toList();
    }
    update();
  }

  sortByPrice({required bool ascending}) {
    List<Product> sortedProducts = List<Product>.from(productsInUI);
    sortedProducts.sort((a, b) => ascending
        ? a.price!.compareTo(b.price!)
        : b.price!.compareTo(a.price!));
    productsInUI = sortedProducts;
    update();
  }
}
