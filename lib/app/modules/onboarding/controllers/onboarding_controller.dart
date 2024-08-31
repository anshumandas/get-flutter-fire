import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../login/bindings/login.dart';

class OnBoardingController extends GetxController{
  static OnBoardingController get instance => Get.find();

//Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  void updatePageIndicator(index) => currentPageIndex.value = index;

  void dotNavigationClick(index){
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage(){
    if(currentPageIndex.value == 2){
      final storage = GetStorage();

      if(kDebugMode){
        print('-------------Get Storage----------------');
        print(storage.read('IsFirstTime'));
      }

      storage.write('isFirstTime', false);
      Get.offAll(const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage(){
    int page = currentPageIndex.value + 1;
    pageController.jumpToPage(page);
  }

}