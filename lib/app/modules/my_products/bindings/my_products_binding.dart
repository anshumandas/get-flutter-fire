import 'package:get/get.dart';

import '../controllers/my_products_controller.dart';

class MyProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyProductsController>(
      () => MyProductsController(),
    );
  }
}
