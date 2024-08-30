import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'services/auth_service.dart';
import 'services/firestore_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();

  // Initialize services
  Get.put(FirestoreService());
  Get.put(AuthService());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "EduRyde",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: BindingsBuilder(() {
        Get.put(AuthService());
      }),
      navigatorObservers: [
        GetObserver(MiddlewareRunner.observer), // Custom observer
      ],
    );
  }
}

class MiddlewareRunner {
  static void observer(Routing? routing) {
    if (routing?.current == routing?.previous) return;

    AuthService authService = Get.find<AuthService>();
    if (authService.currentUser != null) {
      if (Get.currentRoute == Routes.LOGIN) {
        Get.offAllNamed(Routes.HOME);
      }
    } else {
      if (Get.currentRoute != Routes.LOGIN && Get.currentRoute != Routes.REGISTER) {
        Get.offAllNamed(Routes.LOGIN);
      }
    }
  }
}