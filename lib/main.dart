import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';

void main() async {

  bool _isDarkMode = false;

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
        // ignore: dead_code
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
          highlightColor: Colors.black.withOpacity(0.5),
          bottomSheetTheme:
              const BottomSheetThemeData(surfaceTintColor: Colors.blue)),
    ),
  );
  void toggleThemeMode() 
  {
    _isDarkMode = !_isDarkMode;
  };
  ElevatedButton(
    onPressed: toggleThemeMode,
    child: Text(_isDarkMode ? 'Light Mode' : 'Dark Mode'),
  );
}

