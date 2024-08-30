import 'package:get/get.dart';
import '../controllers/products_admin_controller.dart';

class ProductsAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsAdminController>(() => ProductsAdminController());
  }
}
