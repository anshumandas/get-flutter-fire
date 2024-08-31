// lib/app/modules/product_details/bindings/product_details_binding.dart
import 'package:get/get.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure the correct type is used
    Get.put<ProductDetailsController>(ProductDetailsController(Get.parameters['productId'] ?? ''));
  }
}
