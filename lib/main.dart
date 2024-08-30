// ignore_for_file: inference_failure_on_instance_creation

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'services/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final ThemeController themeController = Get.put(ThemeController());

  runApp(
    Obx(() => GetMaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Application',
          initialBinding: BindingsBuilder(
            () {
              Get.put(AuthService());
              Get.lazyPut<ThemeController>(
                () => ThemeController(),
              );
            },
          ),
          getPages: AppPages.routes,
          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
          theme: ThemeData(
            colorScheme: themeController.selectedPersona.value.colorScheme,
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor:
                  themeController.selectedPersona.value.colorScheme.surface,
            ),
            highlightColor: Colors.black.withOpacity(0.5),
          ),
          darkTheme: ThemeData.dark().copyWith(
            colorScheme: themeController.selectedPersona.value.colorScheme,
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor:
                  themeController.selectedPersona.value.colorScheme.surface,
            ),
          ),
        )),
  );
}
