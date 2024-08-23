import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:get_flutter_fire/firebase_options.dart';

import '../../../../models/screens.dart';
import '../../../widgets/login_widgets.dart';
import '../controllers/login_controller.dart';
import '../../../widgets/captcha.dart';  // Import the Captcha widget

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

  Widget footerBuilder(Rx<bool> show, Rxn<fba.EmailAuthCredential> credential) {
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
            MyEmailAuthProvider(),
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
          MyEmailAuthProvider(),
        ],
        showAuthActionSwitch: !controller.isAnon,
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
            Captcha((String token) async {
              bool isValid = await LoginController.to.verifyRecaptcha(token);
              if (isValid) {
                LoginController.to.isRecaptchaVerified.value = true;
              } else {
                Get.snackbar('Error', 'reCAPTCHA verification failed. Please try again.');
              }
            }),
            const SizedBox(height: 20),
            Obx(() => ElevatedButton(
              onPressed: () {
                if (LoginController.to.isRecaptchaVerified.value) {
                  // Force navigation to login page
                  Get.offNamed(Screen.LOGIN.route);
                } else {
                  Get.snackbar('Error', 'Please complete the reCAPTCHA verification.');
                }
              },
              child: const Text('Submit'),
            )),
          ],
        ),
      ),
    );
  }

  List<FirebaseUIAction> getActions() {
    return [
      AuthStateChangeAction<AuthFailed>((context, state) => 
        LoginController.to.handleAuthError(context, state)),
    ];
  }
}

class MyEmailAuthProvider extends EmailAuthProvider {
  @override
  void onCredentialReceived(
    fba.EmailAuthCredential credential,
    AuthAction action,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LoginController.to.credential.value = credential;
    });
    super.onCredentialReceived(credential, action);
  }
}

class EmailLinkButton extends StatelessWidget {
  final Rx<bool> show;
  final Rxn<fba.EmailAuthCredential> credential;

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
