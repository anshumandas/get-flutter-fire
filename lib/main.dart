// ignore_for_file: inference_failure_on_instance_creation

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '.buildConfig.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'services/recaptcha_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (GetPlatform.isWeb) {
    await GRecaptchaV3.ready(BuildConfig.instance.recaptchaSiteKey);
  }

  runApp(
    GetMaterialApp.router(
      debugShowCheckedModeBanner:
          false, //the debug banner will automatically disappear in prod build
      title: 'Application',
      initialBinding: BindingsBuilder(
        () {
          Get.put(AuthService());
          Get.put(RecaptchaService());
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
