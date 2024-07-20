import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/screen_widget.dart';

class RootController extends GetxController {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var topRightButtons = <Widget>[].obs;

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void updateTopRightButtons(GetNavConfig getNavConfig) async {
    final buttons =
        await ScreenWidgetExtension.topRightMenuButtons(getNavConfig);
    topRightButtons.assignAll(buttons);
  }
}
