import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'app/modules/settings/controllers/settings_controller.dart';
import 'app/modules/cart/controllers/cart_controller.dart';
import 'app/modules/products/controllers/products_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final SettingsController settingsController = Get.put(SettingsController());
  bool isDarkMode = settingsController.isDarkMode.value;

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
        primarySwatch: Colors.pink,
        primaryColor: Colors.pinkAccent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          primary: Colors.pinkAccent,
          secondary: Colors.purpleAccent,
        ),
        scaffoldBackgroundColor: Colors.pink.shade50,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.pinkAccent,
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.pink.shade900),
          bodyMedium: TextStyle(color: Colors.pink.shade600),
          titleMedium: TextStyle(color: Colors.white, fontSize: 20),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.pink,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.pink.shade100,
        ),
        cardColor: Colors.pink.shade50,
      ),
      darkTheme: ThemeData.dark(), // Define your dark theme here
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
    ),
  );
}
