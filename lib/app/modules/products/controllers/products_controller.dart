import 'package:get/get.dart';

import '../../../../models/product.dart';

class ProductsController extends GetxController {
  final products = <Product>[].obs;

  void loadDemoProductsFromSomeWhere() {
    products.addAll([
      Product(
        name: 'Vidisha\'s T-Shirt',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imageUrl: "https://picsum.photos/id/91/72/72",
      ),
      Product(
        name: 'Shoes for Anita',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imageUrl: "https://picsum.photos/id/103/72/72",
      ),
      Product(
        name: 'Frok Designed by Anita',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imageUrl: "https://picsum.photos/id/325/72/72",
      ),
      Product(
        name: 'Hoodie Designed By Mr. Chaturvedi',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imageUrl: "https://picsum.photos/id/338/72/72",
      ),
      Product(
        name: 'Miami Beach T-Shirt',
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        imageUrl: "https://picsum.photos/id/349/72/72",
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
