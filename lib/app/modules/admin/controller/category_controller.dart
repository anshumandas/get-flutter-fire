import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:get_flutter_fire/models/category_model.dart';

class CategoryController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  RxList<CategoryModel> categories = <CategoryModel>[].obs;

  // Fetch all categories from Firestore
  Future<void> fetchCategories() async {
    try {
      final querySnapshot = await firestore.collection('categories').get();
      categories.value = querySnapshot.docs
          .map((doc) => CategoryModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching categories: $e');
      }
    }
  }

  // Add a new category to Firestore
  Future<void> addCategory(CategoryModel category, {File? imageFile}) async {
    try {
      String? imageUrl;
      if (imageFile != null) {
        // Upload image to Firebase Storage and get URL
        final ref = storage.ref().child('categories/${category.id}');
        await ref.putFile(imageFile);
        imageUrl = await ref.getDownloadURL();
      } else {
        imageUrl = category.imageUrl;
      }
      final newCategory = category.copyWith(imageUrl: imageUrl);
      await firestore
          .collection('categories')
          .doc(newCategory.id)
          .set(newCategory.toMap());
      categories.add(newCategory);
    } catch (e) {
      if (kDebugMode) {
        print('Error adding category: $e');
      }
      rethrow;
    }
  }

  // Delete a category from Firestore
  Future<void> deleteCategory(String id) async {
    try {
      await firestore.collection('categories').doc(id).delete();
      categories.removeWhere((category) => category.id == id);
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting category: $e');
      }
    }
  }
}
