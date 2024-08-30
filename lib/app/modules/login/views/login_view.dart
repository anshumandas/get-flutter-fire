import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../firebase_options.dart';

import '../../../../models/screens.dart';
import '../../../widgets/login_widgets.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  void showReverificationButton(
      bool show, fba.EmailAuthCredential? credential) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.showReverificationButton.value = show;
    });
  }

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
      ui = !(GetPlatform.isAndroid || GetPlatform.isIOS) && controller.isRobot
          ? recaptcha()
          : SignInScreen(
              providers: [
                GoogleProvider(clientId: DefaultFirebaseOptions.webClientId),
                MyEmailAuthProvider(),
              ],
              showAuthActionSwitch: !controller.isRegistered,
              showPasswordVisibilityToggle: true,
              headerBuilder: LoginWidgets.headerBuilder,
              subtitleBuilder: subtitleBuilder,
              footerBuilder: (context, action) => footerBuilder(
                  controller.showReverificationButton,
                  LoginController.to.credential),
              sideBuilder: LoginWidgets.sideBuilder,
              actions: getActions(),
            );
    } else if (controller.isAnon) {
      ui = RegisterScreen(
        providers: [
          MyEmailAuthProvider(),
        ],
        showAuthActionSwitch: !controller.isAnon, //if Anon only SignUp
        showPasswordVisibilityToggle: true,
        headerBuilder: LoginWidgets.headerBuilder,
        subtitleBuilder: subtitleBuilder,
        footerBuilder: (context, action) => footerBuilder(
            controller.showReverificationButton, LoginController.to.credential),
        sideBuilder: LoginWidgets.sideBuilder,
        actions: getActions(),
      );
    } else {
      final thenTo = Get
          .rootDelegate.currentConfiguration!.currentPage!.parameters?['then'];
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
          children: <Widget>[
            ElevatedButton(
              onPressed: () => controller.verifyPhoneNumber(),
              child: const Text('Verify Phone Number'),
            ),
            TextButton(
              onPressed: () => controller.robot = false,
              child: const Text("Are you a Robot?"),
            ),
          ],
        ),
      ),
    );
  }

  List<FirebaseUIAction> getActions() {
    return [
      AuthStateChangeAction<AuthFailed>((context, state) {
        // Handle AuthFailed state here
        controller.errorMessage('Authentication failed');
      }),
      // Add other actions if needed
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
              child: const Text('Resend Verification Mail'),
            ),
          ),
        ));
  }
}
