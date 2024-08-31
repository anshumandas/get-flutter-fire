import 'package:flutter_easyloading/flutter_easyloading.dart';

showLoader() async {
  await EasyLoading.show();
}

dismissLoader() async {
  await EasyLoading.dismiss();
}
