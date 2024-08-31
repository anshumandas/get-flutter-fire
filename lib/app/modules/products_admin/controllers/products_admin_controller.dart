import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/models/products_admin.dart';

class ProductsAdminController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference prodCollection;
  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescriptionCtrl = TextEditingController();
  TextEditingController productImgCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();
  String category = 'Category';
  String brand = 'Brand';
  bool offer = false;

  List<Product> products = [];
  @override
  Future<void> onInit() async {
    prodCollection = firestore.collection('products');
    await fetchProducts();
    super.onInit();
  }

  addProduct() {
    try {
      DocumentReference doc = prodCollection.doc();
      Product product = Product(
        id: doc.id,
        name: productNameCtrl.text,
        category: category,
        description: productDescriptionCtrl.text,
        price: double.tryParse(productPriceCtrl.text),
        brand: brand,
        image: productImgCtrl.text,
        offer: offer,
      );
      final productJson = product.toJson();
      doc.set(productJson);
      Get.snackbar('Success', 'Product Added Successfully',
          colorText: Colors.green);
      setDefaultValues();
      fetchProducts();
    } on Exception catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.green);
      print(e);
    }
  }

  setDefaultValues() {
    productNameCtrl.clear();
    productDescriptionCtrl.clear();
    productPriceCtrl.clear();
    productImgCtrl.clear();
    category = 'Category';
    brand = 'Brand';
    offer = false;
    update();
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await prodCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrievedProducts);
    } on Exception catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally {
      update();
    }
  }

  deleteProduct(String id) async {
    try {
      await prodCollection.doc(id).delete();
      fetchProducts();
      Get.snackbar('Success', 'Products Deleted Successfully',
          colorText: Colors.green);
    } on Exception catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }
}
