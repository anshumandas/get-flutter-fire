// ignore_for_file: inference_failure_on_function_invocation

import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/firebase_options.dart';

import '../../../../models/screens.dart';
import '../../../widgets/login_widgets.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  void showReverificationButton(
      bool show, fba.EmailAuthCredential? credential) {
    // Below is very important.
    // See [https://stackoverflow.com/questions/69351845/this-obx-widget-cannot-be-marked-as-needing-to-build-because-the-framework-is-al]
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.showReverificationButton.value = show;
    });
    //or Future.delayed(Duration.zero, () {
    // We can get the email and password from the controllers either by making the whole screen from scratch
    // or probably by add flutter_test find.byKey (hacky)
    // tried using AuthStateChangeAction<CredentialReceived> instead which is not getting called
    // Finally Subclassed EmailAuthProvider to handle the same, but that also did not work
    // So went for server side email sending option
    //}));
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
                GoogleProvider(
                  clientId: DefaultFirebaseOptions.currentPlatform.iosClientId!,
                ),
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
    //TODO: Add Recaptcha
    return Scaffold(
        body: TextButton(
      onPressed: () => controller.robot = false,
      child: const Text("Are you a Robot?"),
    ));
  }

  /// The following actions are useful here:
  /// - [AuthStateChangeAction]
  /// - [AuthCancelledAction]
  /// - [EmailLinkSignInAction]
  /// - [VerifyPhoneAction]
  /// - [SMSCodeRequestedAction]

  List<FirebaseUIAction> getActions() {
    return [
      // AuthStateChangeAction<CredentialReceived>((context, state) {
      AuthStateChangeAction<AuthFailed>((context, state) => LoginController.to
          .errorMessage(context, state, showReverificationButton)),
      // AuthStateChangeAction<SignedIn>((context, state) {
      //   // This is not required due to the AuthMiddleware
      // }),
      // EmailLinkSignInAction((context) {
      //   final thenTo = Get.rootDelegate.currentConfiguration!.currentPage!
      //       .parameters?['then'];
      //   Get.rootDelegate.offNamed(thenTo ?? Routes.PROFILE);
      // }),
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
