import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import '../../../../firebase_options.dart';

import '../../../../models/screens.dart';
import '../../../widgets/login_widgets.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => loginScreen(context));
  }

  Widget subtitleBuilder(context, action) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: action == AuthAction.signIn
          ? const Text('Welcome to Get Flutter Fire, please sign in!')
          : const Text('New to Get Flutter Fire, please sign up!'),
    );
  }

  Widget footerBuilder(Rx<bool> show, Rxn<fba.AuthCredential> credential) {
    return LoginWidgets.footerBuilder(EmailLinkButton(show, credential));
  }

  Widget loginScreen(BuildContext context) {
    Widget ui;
    if (!controller.isLoggedIn) {
      if (GetPlatform.isWeb && !controller.isRecaptchaVerified.value) {
        ui = recaptcha();
      } else {
        ui = SignInScreen(
          providers: [
            GoogleProvider(clientId: DefaultFirebaseOptions.currentPlatform.appId),
            EmailAuthProvider(),
          ],
          showAuthActionSwitch: !controller.isRegistered,
          showPasswordVisibilityToggle: true,
          headerBuilder: LoginWidgets.headerBuilder,
          subtitleBuilder: subtitleBuilder,
          footerBuilder: (context, action) => footerBuilder(
              controller.showReverificationButton,
              controller.credential),
          sideBuilder: LoginWidgets.sideBuilder,
          actions: getActions(),
        );
      }
    } else if (controller.isAnon) {
      ui = RegisterScreen(
        providers: [
          EmailAuthProvider(),
        ],
        showAuthActionSwitch: false,
        showPasswordVisibilityToggle: true,
        headerBuilder: LoginWidgets.headerBuilder,
        subtitleBuilder: subtitleBuilder,
        footerBuilder: (context, action) => footerBuilder(
            controller.showReverificationButton, controller.credential),
        sideBuilder: LoginWidgets.sideBuilder,
        actions: getActions(),
      );
    } else {
      final thenTo = Get.rootDelegate.currentConfiguration!.currentPage!.parameters?['then'];
      Get.rootDelegate.offNamed(thenTo ??
          (controller.isRegistered ? Screen.HOME : Screen.REGISTER).route);
      ui = const Scaffold();
    }
    return ui;
  }

  Widget recaptcha() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Please verify that you're not a robot"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (GetPlatform.isWeb) {
                  await GRecaptchaV3.ready("6Lee5w8qAAAAACWwRz5z4VOyPxB4Rt-ODByWTwvz");
                }
                bool verified = await controller.verifyRecaptcha();
                if (verified) {
                  controller.update();
                } else {
                  Get.snackbar('Error', 'reCAPTCHA verification failed. Please try again.');
                }
              },
              child: const Text("Verify I'm not a robot"),
            ),
          ],
        ),
      ),
    );
  }

  List<FirebaseUIAction> getActions() {
    return [
      AuthStateChangeAction<AuthFailed>((context, state) {
        controller.errorMessage(context, state, (show, credential) {
          controller.showReverificationButton.value = show;
          controller.credential.value = credential;
        });
      }),
    ];
  }
}

class EmailLinkButton extends StatelessWidget {
  final Rx<bool> show;
  final Rxn<fba.AuthCredential> credential;

  const EmailLinkButton(
      this.show,
      this.credential, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Visibility(
        visible: show.value,
        child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ElevatedButton(
                onPressed: () => LoginController.to
                    .sendVerificationMail(emailAuth: credential.value),
                child: const Text('Resend Verification Mail')))));
  }
}