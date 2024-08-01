import 'package:get/get.dart';

class ProductController extends GetxController {
  var count = 1.obs;

  void incrementCount() {
    count++;
  }

  void decrementCount() {
    if (count > 1) {
      count--;
    }
  }
}