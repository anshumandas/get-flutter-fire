import 'package:get/get.dart';

import '../../../../models/product.dart';

class ProductsController extends GetxController {
  final products = <Product>[].obs;
  final searchQuery = ''.obs;
  final selectedPersons = 1.obs;
  final selectedCheckInDate = Rxn<DateTime>();
  final selectedCheckOutDate = Rxn<DateTime>();


  void loadDemoProductsFromSomeWhere() {
    products.assignAll([
      Product(
          id: '1',
          name: 'Fiona Apartment',
          location: 'Powai Mumbai',
          price: 2200,
          imageAsset: 'assets/Fiona/F1.jpeg'),

      Product(
          id: '2',
          name: 'Historia Apartment',
          location: 'Goa',
          price: 4300,
          imageAsset: 'assets/Historia/H1.jpeg'),

      Product(
          id: '3' ,
          name: 'Plush Stays' ,
          location: 'Khar,Mumbai' ,
          price: 3800,
          imageAsset: 'assets/Plush/P1.jpeg'),

      Product(
          id: '4',
          name: 'Flora Inn',
          location: 'Lonavala',
          price: 5000,
          imageAsset: 'assets/Flora/FL1.jpeg'),

      Product(
          id: '5',
          name: 'Stay Vista',
          location: 'Thane',
          price: 2200,
          imageAsset: 'assets/Stay/S1.jpeg' ),

      Product(
          id: '6',
          name: 'Eva Studios',
          location: 'Mumbai',
          price: 1200,
          imageAsset: 'assets/Eva/E1.jpeg'),
    ]);
  }

  // Get filtered products based on the search query
  List<Product> get filteredProducts {
    if (searchQuery.value.isEmpty) {
      return products;
    } else {
      return products.where((product) {
        return product.name.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  @override
  void onReady() {
    super.onReady();
    loadDemoProductsFromSomeWhere();
  }

  @override
  void onClose() {
    Get.printInfo(info: 'Products: onClose');
    super.onClose();
  }
}
