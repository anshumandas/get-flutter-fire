// ignore_for_file: inference_failure_on_function_invocation

import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/screens.dart';
import '../../../widgets/login_widgets.dart';
import '../controllers/login_controller.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
const webClientId = "-...";


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
    return Column(
      children: [
        LoginWidgets.footerBuilder(EmailLinkButton(show, credential)),
        const SizedBox(height: 16), // Add spacing between the terms and the button
        ElevatedButton(
          onPressed: () => controller.guestlogin(),
          child: const Text('Anonymous login'),
        ),
      ],
    );
  }

  Widget loginScreen(BuildContext context) {
    Widget ui;
    if (!controller.isLoggedIn) {
      ui = !(GetPlatform.isAndroid || GetPlatform.isIOS) && controller.isRobot
          ? recaptcha()
          : SignInScreen(
        providers: [
          GoogleProvider(clientId: webClientId),
          MyEmailAuthProvider(),
          PhoneAuthProvider(),
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
          PhoneAuthProvider(),
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
      AuthStateChangeAction<AuthFailed>((context, state) {
        LoginController.to.errorMessage(context, state, showReverificationButton);
      }),
      // Custom action to handle reCAPTCHA before login
      AuthStateChangeAction<SignedIn>((context, state) async {
        // Execute reCAPTCHA verification
        final token = await GRecaptchaV3.execute('6Lf14DIqAAAAACuem09M2pNG11N8tb71nficHV4x');
        if (token != null) {
          print("ReCaptcha token: $token");
          // You might want to handle the token here, such as sending it to your server
          // or using it to verify the user.
        } else {
          print("ReCaptcha failed");
          // Handle reCAPTCHA failure, e.g., show an error message or retry
        }
      }),
      // Other actions
      // EmailLinkSignInAction((context) {
      //   final thenTo = Get.rootDelegate.currentConfiguration!.currentPage!.parameters?['then'];
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