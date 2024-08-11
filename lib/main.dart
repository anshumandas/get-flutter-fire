// ignore_for_file: inference_failure_on_instance_creation

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'services/persona_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (GetPlatform.isWeb) {
    bool ready = await GRecaptchaV3.ready(DefaultFirebaseOptions.sitekey); 
    print("Is Recaptcha ready? $ready");
  }
  Get.lazyPut(() => PersonaService());
  runApp(
    GetMaterialApp.router(
      debugShowCheckedModeBanner:
          false, //the debug banner will automatically disappear in prod build
      title: 'Application',
      initialBinding: BindingsBuilder(
        () {
          Get.put(AuthService());
          Get.put(PersonaService());
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
     theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: Get.find<PersonaService>().themeMode,
    ),
  );
}
