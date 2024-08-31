import 'package:get/get.dart';
import '../controllers/Ranking_Controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<RankingController>(() => RankingController());

  }
}
