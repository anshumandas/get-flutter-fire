import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_flutter_fire/models/category.dart';

class CategoriesController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<Category> categories = <Category>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;
    try {
      print('Fetching categories...');
      QuerySnapshot querySnapshot =
          await _firestore.collection('categories').get();
      print('Fetched ${querySnapshot.docs.length} category documents');

      categories.value = querySnapshot.docs.map((doc) {
        print('Processing category document: ${doc.id}');
        print('Category data: ${doc.data()}');
        return Category.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      print('Processed ${categories.length} categories');
      categories.forEach((category) {
        print('Category: ${category.id} - ${category.name}');
      });
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
