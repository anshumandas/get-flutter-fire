import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../firebase_options.dart';
import '../../../../models/screens.dart';
import '../../../widgets/login_widgets.dart';
import '../controllers/login_controller.dart';

import '../../../widgets/captcha_web.dart' if (dart.library.io) '../../../widgets/captcha.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (kIsWeb && !controller.isCaptchaVerified.value) {
        return Captcha((token) => controller.verifyCaptcha(token));
      } else {
        return loginScreen(context);
      }
    });
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
      ui = !(GetPlatform.isAndroid || GetPlatform.isIOS) && controller.isRobot
          ? recaptcha()
          : SignInScreen(
              providers: [
                GoogleProvider(clientId: DefaultFirebaseOptions.webClientId),
                MyEmailAuthProvider(),
                PhoneAuthProvider(), // Add PhoneAuthProvider for phone login
              ],
              showAuthActionSwitch: !controller.isRegistered,
              showPasswordVisibilityToggle: true,
              headerBuilder: LoginWidgets.headerBuilder,
              subtitleBuilder: subtitleBuilder,
              footerBuilder: (context, action) => Column(
                children: [
                  footerBuilder(controller.showReverificationButton,
                      LoginController.to.credential),
                  // Add "Login as Guest" Button
                  ElevatedButton(
                    onPressed: () => controller.loginAsGuest(),
                    child: const Text('Login as Guest'),
                  ),
                ],
              ),
              sideBuilder: LoginWidgets.sideBuilder,
              actions: getActions(),
            );
    } else if (controller.isAnon) {
      ui = RegisterScreen(
        providers: [
          MyEmailAuthProvider(),
          PhoneAuthProvider(), // Add PhoneAuthProvider for phone sign-up
        ],
        showAuthActionSwitch: !controller.isAnon, // if Anon only SignUp
        showPasswordVisibilityToggle: true,
        headerBuilder: LoginWidgets.headerBuilder,
        subtitleBuilder: subtitleBuilder,
        footerBuilder: (context, action) => Column(
          children: [
            footerBuilder(controller.showReverificationButton,
                LoginController.to.credential),
            // Add "Login as Guest" Button
            ElevatedButton(
              onPressed: () => controller.loginAsGuest(),
              child: const Text('Login as Guest'),
            ),
          ],
        ),
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
      body: TextButton(
        onPressed: () => controller.robot = false,
        child: const Text("Are you a Robot ?"),
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
