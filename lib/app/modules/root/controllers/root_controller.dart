import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final RxBool isSearchVisible = false.obs;

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void toggleSearch() {
    isSearchVisible.toggle();
  }
}