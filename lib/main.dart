import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Application',
      initialRoute: AppRoutes.main, // Set MainView as the initial route
      getPages: AppRoutes.routes, // Use the defined routes
      theme: ThemeData(
        highlightColor: Colors.black.withOpacity(0.5),
        bottomSheetTheme: const BottomSheetThemeData(surfaceTintColor: Colors.blue),
      ),
    ),
  );
}
