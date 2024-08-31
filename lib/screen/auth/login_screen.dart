// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// // import 'package:your_app/controllers/recaptcha_controller.dart';
// //
// import '../../controllers/recaptcha_controller.dart';
//
// class LoginScreen extends StatelessWidget {
//   final ReCaptchaController reCaptchaController = Get.put(ReCaptchaController());
//
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const TextField(
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             const TextField(
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             const SizedBox(height: 20),
//             Obx(() => reCaptchaController.isVerified.value
//                 ? ElevatedButton(onPressed: () {}, child: const Text('Login'))
//                 : ElevatedButton(
//               onPressed: reCaptchaController.verifyRecaptcha,
//               child: const Text('Verify ReCaptcha'),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/recaptcha_controller.dart';

class LoginScreen extends StatelessWidget {
  final ReCaptchaController reCaptchaController = Get.put(ReCaptchaController());

  // Remove 'const' from the constructor
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Obx(() => reCaptchaController.isVerified.value
                ? ElevatedButton(onPressed: () {}, child: const Text('Login'))
                : ElevatedButton(
              onPressed: reCaptchaController.verifyRecaptcha,
              child: const Text('Verify ReCaptcha'),
            )),
          ],
        ),
      ),
    );
  }
}
