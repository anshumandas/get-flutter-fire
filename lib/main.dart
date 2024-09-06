import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/modules/cart/controllers/cart_controller.dart';
import 'app/modules/settings/controllers/settings_controller.dart';
import 'app/modules/products/controllers/products_controller.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize settings controller to load saved settings before running the app
  final settingsController = Get.put(SettingsController());

  // Run the app
  runApp(
    GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Application',
      initialBinding: BindingsBuilder(
        () {
          Get.put(AuthService());
          Get.put(ProductsController());
          Get.put(CartController());
        },
      ),
      getPages: AppPages.routes,
      theme: ThemeData(
        highlightColor: Colors.black.withOpacity(0.5),
        bottomSheetTheme: const BottomSheetThemeData(surfaceTintColor: Colors.blue),
      ),
      darkTheme: ThemeData.dark(), // Define dark theme if needed
      themeMode: settingsController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    ),
  );
}
