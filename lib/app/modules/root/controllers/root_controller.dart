import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
<<<<<<< HEAD
  final RxBool isSearchVisible = false.obs;
   final isSearching = false.obs;
=======
>>>>>>> origin/main

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }
<<<<<<< HEAD

  void toggleSearch() {
    isSearchVisible.toggle();
  }
}
=======
}
>>>>>>> origin/main
