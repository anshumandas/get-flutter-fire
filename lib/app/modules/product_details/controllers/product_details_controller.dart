import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final String productId;
  final String productName = 'Anshuman Das Gandu hai';

  ProductDetailsController(this.productId);
  @override
  void onInit() {
    super.onInit();
    Get.log('ProductDetailsController created with id: $productId');
  }

  @override
  void onClose() {
    Get.log('ProductDetailsController close with id: $productId');
    super.onClose();
  }
}
