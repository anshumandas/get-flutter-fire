import 'package:get/get.dart';
import 'package:get_flutter_fire/models/product.dart';

class CartController extends GetxController {
  //TODO: Implement CartController

  final count = 0.obs;

  final RxList<Product> _products = <Product>[].obs;

  void addProduct(Product product) {
    _products.add(product);
  }

  List<Product> getProducts() {
    return _products;
  }

  get total => _products.length;

  void increment() => count.value++;
}
