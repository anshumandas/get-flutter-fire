import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/routes/app_pages.dart';
import 'package:get_flutter_fire/firebase_options.dart';
import 'package:get_storage/get_storage.dart';

import 'app/modules/cart/controllers/cart_controller.dart';
import 'app/modules/root/controllers/root_controller.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Application',
      initialBinding: BindingsBuilder(() {
        Get.put(AuthService(), permanent: true);
        Get.put(CartController(), permanent: true);
        Get.put(RootController(), permanent: true);
      }),
      getPages: AppPages.routes,
      defaultTransition: Transition.fade,
      routerDelegate: GetDelegate(
        notFoundRoute: GetPage(
            name: '/notfound',
            page: () => Scaffold(body: Center(child: Text('Route not found')))),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    ),
  );
}
