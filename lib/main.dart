// ignore_for_file: inference_failure_on_instance_creation

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:get_flutter_fire/app/modules/settings/controllers/settings_controller.dart';
import 'package:get_storage/get_storage.dart';

import 'app/modules/products/controllers/products_controller.dart';
=======
import 'package:get_storage/get_storage.dart';

>>>>>>> origin/main
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    GetMaterialApp.router(
      debugShowCheckedModeBanner:
          false, //the debug banner will automatically disappear in prod build
      title: 'Application',
      initialBinding: BindingsBuilder(
        () {
          Get.put(AuthService());
<<<<<<< HEAD
          Get.put(ProductsController(), permanent: true);
          Get.put(SettingsController(), permanent: true);
=======
>>>>>>> origin/main
        },
      ),
      getPages: AppPages.routes,
      // routeInformationParser: GetInformationParser(
      //     // initialRoute: Routes.HOME,
      //     ),
      // routerDelegate: GetDelegate(
      //   backButtonPopMode: PopMode.History,
      //   preventDuplicateHandlingMode:
      //       PreventDuplicateHandlingMode.ReorderRoutes,
      // ),
      theme: ThemeData(
          highlightColor: Colors.black.withOpacity(0.5),
          bottomSheetTheme:
              const BottomSheetThemeData(surfaceTintColor: Colors.blue)),
    ),
  );
}
