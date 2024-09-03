import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/AppTheme.dart';
import 'package:get_flutter_fire/app/modules/welcome/views/welcome_view.dart';
import 'package:get_flutter_fire/app/routes/app_pages.dart';
import 'package:get_flutter_fire/firebase_options.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/modules/cart/controllers/cart_controller.dart';
import 'app/modules/root/controllers/root_controller.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(MyApp());
}

Future<void> initServices() async {
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => CartController().init());
  await Get.putAsync(() => RootController().init());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping Master',
      theme: AppTheme.lightTheme,
      home: FutureBuilder<bool>(
        future: Get.find<AuthService>().checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            if (snapshot.data == true) {
              // User is logged in
              final homePage = AppPages.routes
                  .firstWhereOrNull((page) => page.name == Routes.HOME);
              return homePage?.page?.call() ?? WelcomeView();
            } else {
              // User is not logged in
              return WelcomeView();
            }
          }
        },
      ),
      getPages: AppPages.routes,
    );
  }
}
