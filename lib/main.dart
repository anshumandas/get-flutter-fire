import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/modules/settings/controllers/settings_controller.dart';
import 'app/modules/cart/controllers/cart_controller.dart';
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
        primaryColor: pastelGold,
        scaffoldBackgroundColor: pastelBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: pastelGold,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: pastelGold,
          textTheme: ButtonTextTheme.primary,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: pastelGold,
        ),
        colorScheme: ColorScheme.light(
          primary: pastelGold,
          onPrimary: Colors.black,
          secondary: pastelBeige,
          onSecondary: Colors.black,
          background: pastelBackground,
          surface: pastelCream,
          onSurface: pastelBrown,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: pastelBrown),
          bodyMedium: TextStyle(color: pastelBrown),
          displayLarge: TextStyle(color: pastelGold),
          displayMedium: TextStyle(color: pastelGold),
          labelLarge: TextStyle(color: Colors.black),
        ),
        cardTheme: CardTheme(
          color: pastelCream,
          shadowColor: pastelBrown.withOpacity(0.3),
          margin: EdgeInsets.all(8.0),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: pastelCream,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: pastelBrown),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pastelGold),
          ),
          labelStyle: TextStyle(color: pastelBrown),
        ),
        iconTheme: IconThemeData(color: pastelBrown),
        dividerColor: pastelBrown.withOpacity(0.5),
      ),
      darkTheme: ThemeData.dark(), // Define dark theme if needed
      themeMode: settingsController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    ),
  );
}

// Golden Pastel Colors
const Color pastelGold = Color(0xFFF4D06F);
const Color pastelCream = Color(0xFFFDF6E3);
const Color pastelBeige = Color(0xFFE7CBA9);
const Color pastelBrown = Color(0xFF8D775F);
const Color pastelBackground = Color(0xFFF7EFE5);
