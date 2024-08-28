//lib/app/modules/search/bindings/search_binding.dart
import 'package:get/get.dart';

import '../controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchBarController>(
          () => SearchBarController(),
    );
  }
}