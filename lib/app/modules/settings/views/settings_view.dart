<<<<<<< HEAD
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_flutter_fire/app/modules/settings/controllers/settings_controller.dart';
// import 'package:get_flutter_fire/models/screens.dart';

// import '../../../routes/app_pages.dart';

// class SettingsView extends GetView<SettingsController> {
//   const SettingsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           Obx(() => ListTile(
//             title: Text('Dark Mode'),
//             subtitle: Text(controller.currentPersona.value == null ? 'Applies to default theme' : 'Disabled when using a persona'),
//             trailing: Switch(
//               value: controller.isDarkMode.value,
//               onChanged: controller.currentPersona.value == null
//                   ? (value) => controller.toggleDarkMode()
//                   : null,
//             ),
//           )),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/persona/persona_controller.dart';

class SettingsController extends GetxController {
  final selectedPersona = Rx<Persona?>(null);
  final isDarkMode = false.obs;

  void setPersona(Persona? persona) {
    selectedPersona.value = persona;
    if (persona != null) {
      Get.changeTheme(ThemeData(
        primaryColor: persona.primaryColor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(persona.primaryColor.value, {
            50: persona.primaryColor.withOpacity(0.1),
            100: persona.primaryColor.withOpacity(0.2),
            200: persona.primaryColor.withOpacity(0.3),
            300: persona.primaryColor.withOpacity(0.4),
            400: persona.primaryColor.withOpacity(0.5),
            500: persona.primaryColor.withOpacity(0.6),
            600: persona.primaryColor.withOpacity(0.7),
            700: persona.primaryColor.withOpacity(0.8),
            800: persona.primaryColor.withOpacity(0.9),
            900: persona.primaryColor.withOpacity(1.0),
          }),
        ).copyWith(
          secondary: persona.secondaryColor,
        ),
        scaffoldBackgroundColor: persona.backgroundColor,
        textTheme: ThemeData.light().textTheme.apply(
          bodyColor: persona.textColor,
          displayColor: persona.textColor,
        ),
      ));
    } else {
      Get.changeTheme(isDarkMode.value ? ThemeData.dark() : ThemeData.light());
    }
  }

  void toggleDarkMode() {
    isDarkMode.toggle();
    if (selectedPersona.value != null) {
      setPersona(selectedPersona.value!.copyWith(isDarkMode: isDarkMode.value));
    } else {
      Get.changeTheme(isDarkMode.value ? ThemeData.dark() : ThemeData.light());
    }
  }
}
=======
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'SettingsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
>>>>>>> origin/main
