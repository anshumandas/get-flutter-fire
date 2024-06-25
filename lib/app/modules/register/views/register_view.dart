// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../services/auth_service.dart';
// import '../../../widgets/login_widgets.dart';
import '../controllers/register_controller.dart';

//ALso add a form to take additional info such as display name of other customer details mapped with uid in Firestore
class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    // Add pre verification Form if any. Mostly it can be post verification and can be the Profile or Setting screens
    try {
      // using this is causing an error when we send verification mail from server side
      // if it was initiated once, even when no visible. So we need to dispose when not visible
      var w =
          // EmailVerificationScreen(
          //   headerBuilder: LoginWidgets.headerBuilder,
          //   sideBuilder: LoginWidgets.sideBuilder,
          //   actions: [
          //     EmailVerifiedAction(() {
          //       AuthService.to.register();
          //     }),
          //   ],
          // );
          Scaffold(
        appBar: AppBar(
          title: const Text('Registeration'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(children: [
          const Text(
            'Please verify your email (check SPAM folder), and then relogin',
            style: TextStyle(fontSize: 20),
          ),
          TextButton(
            onPressed: () => AuthService.to.register(),
            child: const Text("Verification Done. Relogin"),
          )
        ])),
      );
      return w;
    } catch (e) {
      // TODO
    }
    return const Scaffold();
  }
}
