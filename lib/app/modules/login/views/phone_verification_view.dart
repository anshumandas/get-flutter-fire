// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/login_controller.dart';
//
// class PhoneVerificationView extends StatelessWidget {
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController codeController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Phone Verification'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: phoneController,
//               decoration: InputDecoration(labelText: 'Phone Number'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 LoginController.to.verifyPhoneNumber(
//                   phoneController.text,
//                       (credential) {
//                     // Handle verification completed
//                     Get.snackbar('Success', 'Phone number verified');
//                   },
//                 );
//               },
//               child: Text('Verify Phone Number'),
//             ),
//             TextField(
//               controller: codeController,
//               decoration: InputDecoration(labelText: 'Verification Code'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 LoginController.to.signInWithPhoneNumber(
//                   LoginController.to.verificationId.value,
//                   codeController.text,
//                 );
//               },
//               child: Text('Sign In'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
