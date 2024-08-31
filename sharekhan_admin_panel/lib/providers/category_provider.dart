import 'package:flutter/material.dart';
import 'package:sharekhan_admin_panel/globals.dart';
import 'package:sharekhan_admin_panel/models/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  Future<void> fetchCategories() async {
    final querySnapshot = await categoriesRef.get();
    _categories = querySnapshot.docs
        .map((doc) => CategoryModel.fromMap(doc.data()))
        .toList();
    notifyListeners();
  }

  Future<void> addCategory(CategoryModel category) async {
    await categoriesRef.doc(category.id).set(category.toMap());
    _categories.add(category);
    notifyListeners();
  }

  Future<void> updateCategory(CategoryModel category) async {
    await categoriesRef.doc(category.id).update(category.toMap());
    _categories.removeWhere((element) => element.id == category.id);
    _categories.add(category);
    notifyListeners();
  }

  Future<void> deleteCategory(CategoryModel category) async {
    await categoriesRef.doc(category.id).delete();
    _categories.removeWhere((element) => element.id == category.id);
    notifyListeners();
  }
}
