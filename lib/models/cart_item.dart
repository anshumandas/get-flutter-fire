import 'package:get/get.dart';
import 'product.dart';

class CartItem {
  final Product product;
  final RxInt quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });
}
