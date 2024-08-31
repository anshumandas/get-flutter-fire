import 'package:get/get.dart';
import '../models/product.dart';

class ProductController extends GetxController {
  final RxList<Product> _products = [
    Product(id: '1', name: 'Product 1', price: 10.0),
    Product(id: '2', name: 'Product 2', price: 15.0),
    Product(id: '3', name: 'Product 3', price: 20.0),
  ].obs;

  List<Product> get products => _products;
}
