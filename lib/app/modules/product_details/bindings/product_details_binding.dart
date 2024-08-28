import 'package:get/get.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<ProductDetailController>(
          () => ProductDetailController(
        int.parse(Get.parameters['productId'] ?? '1'),
      ),
    );
  }
}
