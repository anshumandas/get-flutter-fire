import 'package:get/get.dart';
import '../controllers/root_controller.dart';
import '../../products/bindings/products_binding.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RootController());
    ProductsBinding().dependencies();
  }
}
