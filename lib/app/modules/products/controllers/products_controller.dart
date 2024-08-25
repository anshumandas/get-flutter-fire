import 'package:get/get.dart';

import '../../../../models/product.dart';

class ProductsController extends GetxController {
  final products = <Product>[].obs;

  void loadDemoProductsFromSomeWhere() {
    products.addAll([
      Product(
        name: 'Vidisha\'s T-Shirt',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imageUrl: "https://picsum.photos/72/72?random=1",
      ),
      Product(
        name: 'T-Shirt for Anita',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imageUrl: "https://picsum.photos/id/237/72/72",
      ),
      Product(
        name: 'T-Shirt Designed by Anita',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imageUrl: "https://picsum.photos/id/234/72/72",
      ),
      Product(
        name: 'Jeans Designed By Mr. Chaturvedi',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imageUrl: "https://picsum.photos/id/232/72/72",
      ),
      Product(
        name: 'Miami Beach T-Shirt',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imageUrl: "https://picsum.photos/id/217/72/72",
      ),
      Product(
        name: 'No Name T-Shirt',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imageUrl: "https://picsum.photos/id/222/72/72",
      ),
      Product(
        name: 'Beach Lower by Kailash',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imageUrl: "https://picsum.photos/id/123/72/72",
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
