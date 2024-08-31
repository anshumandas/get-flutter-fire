import 'package:flutter/material.dart';
import 'package:sharekhan_admin_panel/globals.dart';
import 'package:sharekhan_admin_panel/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  Future<void> fetchProducts() async {
    final querySnapshot = await productsRef.get();
    _products = querySnapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data()))
        .toList();
    notifyListeners();
  }

  Future<void> addProduct(ProductModel product) async {
    await productsRef.doc(product.id).set(product.toMap());
    _products.add(product);
    notifyListeners();
  }

  Future<void> updateProduct(ProductModel product) async {
    await productsRef.doc(product.id).update(product.toMap());
    _products.removeWhere((element) => element.id == product.id);
    _products.add(product);
    notifyListeners();
  }

  Future<void> deleteProduct(ProductModel product) async {
    await productsRef.doc(product.id).delete();
    _products.removeWhere((element) => element.id == product.id);
    notifyListeners();
  }

  Future<void> toggleActive(ProductModel product, bool isActive) async {
    try {
      int index = _products.indexWhere((element) => element.id == product.id);
      _products[index] = product.copyWith(isActive: isActive);
      notifyListeners();
      await productsRef.doc(product.id).update({'isActive': isActive});
    } catch (e) {
      int index = _products.indexWhere((element) => element.id == product.id);
      _products[index] = product.copyWith(isActive: !isActive);
      notifyListeners();
    }
  }
}
