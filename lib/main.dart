import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'auth_gate.dart';
import 'image_controller.dart'; // Import ImageController
import 'image_uploads.dart'; // Import ImageUploads

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize ImageController globally
  Get.put(ImageController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthGate(), // Use AuthGate for authentication
      routes: {
        '/upload': (context) => ImageUploads(), // Route for ImageUploads screen
      },
    );
  }
}
