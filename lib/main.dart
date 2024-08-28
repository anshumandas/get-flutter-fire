import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/modules/auth/controllers/auth_controller.dart';
import 'firebase_options.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize AuthController
  final authController = Get.put(AuthController());

  // Wait for the authentication state to be available
  // Consider using a stream instead of a delay for better synchronization
  await Future.delayed(Duration(milliseconds: 500)); // Temporary, adjust based on your needs

  // Determine the initial route based on authentication status
  String initialRoute = authController.firebaseUser.value != null
      ? AppRoutes.main
      : AppRoutes.login;

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Application',
      initialRoute: initialRoute,
      getPages: AppRoutes.routes,
      theme: ThemeData(
        highlightColor: Colors.black.withOpacity(0.5),
        bottomSheetTheme: const BottomSheetThemeData(surfaceTintColor: Colors.blue),
      ),
    ),
  );
}
