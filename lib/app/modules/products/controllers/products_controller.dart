import 'package:get/get.dart';

import '../../../../models/product.dart';

class ProductsController extends GetxController {
  final products = <Product>[].obs;

  void loadDemoProductsFromSomeWhere() {
    products.addAll([
      Product(
        name: 'T-Shirt for Anita',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
      Product(
        name: 'T-Shirt Designed by Anita',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
      Product(
        name: 'Jeans Designed By Mr. Chaturvedi',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
      Product(
        name: 'Miami Beach T-Shirt',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
      Product(
        name: 'No Name T-Shirt',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
      Product(
        name: 'Beach Lower by Kailash',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
      ),
    ]);
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
