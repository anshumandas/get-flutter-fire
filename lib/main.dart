// // ignore_for_file: inference_failure_on_instance_creation
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
//
// import 'app/routes/app_pages.dart';
// import 'services/auth_service.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await GetStorage.init();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   runApp(
//     GetMaterialApp.router(
//       debugShowCheckedModeBanner:
//           false, //the debug banner will automatically disappear in prod build
//       title: 'Application',
//       initialBinding: BindingsBuilder(
//         () {
//           Get.put(AuthService());
//         },
//       ),
//       getPages: AppPages.routes,
//       // routeInformationParser: GetInformationParser(
//       //     // initialRoute: Routes.HOME,
//       //     ),
//       // routerDelegate: GetDelegate(
//       //   backButtonPopMode: PopMode.History,
//       //   preventDuplicateHandlingMode:
//       //       PreventDuplicateHandlingMode.ReorderRoutes,
//       // ),
//       theme: ThemeData(
//           highlightColor: Colors.black.withOpacity(0.5),
//           bottomSheetTheme:
//               const BottomSheetThemeData(surfaceTintColor: Colors.blue)),
//     ),
//   );
// }
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_flutter_fire/screen/responsive_layout.dart';
//
// // void main() {
// //   runApp(const MyApp());
// // }
// Future main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   if(kIsWeb){
//     await Firebase.initializeApp(options: FirebaseOptions(apiKey: 'AIzaSyC3XwOe8FpQmq6pELForbSQ-S59RqQDDgA', appId: '1:1071039837988:web:496460b0f356fa8aebe5b1', messagingSenderId: '1071039837988', projectId: 'getflutterfire-96270'));
//     //await Firebase.initializeApp(options: FirebaseOptions(apiKey: AIzaSyC3XwOe8FpQmq6pELForbSQ-S59RqQDDgA, appId: 1:1071039837988:web:49
//   }
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Flutter App',
//       theme: ThemeData(
//         brightness: Brightness.light,
//         primarySwatch: Colors.blue,
//       ),
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//       ),
//       themeMode: ThemeMode.system,
//       home: const ResponsiveLayout(
//         mobileLayout: MobileHomeScreen(),
//         tabletLayout: TabletHomeScreen(),
//         desktopLayout: DesktopHomeScreen(),
//       ),
//     );
//   }
// }
//
// class MobileHomeScreen extends StatelessWidget {
//   const MobileHomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Mobile Home')),
//       body: const Center(child: Text('Mobile Layout')),
//     );
//   }
// }
//
// class TabletHomeScreen extends StatelessWidget {
//   const TabletHomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Tablet Home')),
//       body: const Center(child: Text('Tablet Layout')),
//     );
//   }
// }
//
// class DesktopHomeScreen extends StatelessWidget {
//   const DesktopHomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Desktop Home')),
//       body: const Center(child: Text('Desktop Layout')),
//     );
//   }
// }



import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
// import 'app/routes/app_routes.dart'; // Import the routes
import 'package:get_flutter_fire/screen/responsive_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // Initialize Firebase for the web
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyC3XwOe8FpQmq6pELForbSQ-S59RqQDDgA',
        appId: '1:1071039837988:web:496460b0f356fa8aebe5b1',
        messagingSenderId: '1071039837988',
        projectId: 'getflutterfire-96270',
      ),
    );
  } else {
    // Initialize Firebase for mobile
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,

      // Set the initial route
      initialRoute: AppRoutes.INITIAL,

      // Define the routes
      getPages: AppRoutes.routes,

      home: const ResponsiveLayout(
        mobileLayout: MobileHomeScreen(),
        tabletLayout: TabletHomeScreen(),
        desktopLayout: DesktopHomeScreen(),
      ),
    );
  }
}

class MobileHomeScreen extends StatelessWidget {
  const MobileHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Home')),
      body: const Center(child: Text('Mobile Layout')),
    );
  }
}

class TabletHomeScreen extends StatelessWidget {
  const TabletHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tablet Home')),
      body: const Center(child: Text('Tablet Layout')),
    );
  }
}

class DesktopHomeScreen extends StatelessWidget {
  const DesktopHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Desktop Home')),
      body: const Center(child: Text('Desktop Layout')),
    );
  }
}
