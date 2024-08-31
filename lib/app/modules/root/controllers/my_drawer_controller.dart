import 'package:get/get.dart';

import '../../../../models/screens.dart';

class MyDrawerController extends GetxController {
  MyDrawerController(Iterable<Screen> iter)
      : values = Rx<Iterable<Screen>>(iter);

  final Rx<Iterable<Screen>> values;
}
