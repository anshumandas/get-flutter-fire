import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/categories/controllers/categories_controller.dart';
import 'package:get_flutter_fire/app/modules/products/controllers/products_controller.dart';

class ProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductsController());
    Get.put(CategoriesController());
  }
}
