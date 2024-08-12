<<<<<<< HEAD
import 'package:country_code_picker/country_code_picker.dart';
=======
// ignore_for_file: inference_failure_on_function_invocation

>>>>>>> origin/main
import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
=======
>>>>>>> origin/main
import '../../../../firebase_options.dart';

import '../../../../models/screens.dart';
import '../../../widgets/login_widgets.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
<<<<<<< HEAD
=======
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

>>>>>>> origin/main
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

<<<<<<< HEAD
  Widget footerBuilder(Rx<bool> show, Rxn<fba.AuthCredential> credential) {
=======
  Widget footerBuilder(Rx<bool> show, Rxn<fba.EmailAuthCredential> credential) {
>>>>>>> origin/main
    return LoginWidgets.footerBuilder(EmailLinkButton(show, credential));
  }

  Widget loginScreen(BuildContext context) {
    Widget ui;
    if (!controller.isLoggedIn) {
<<<<<<< HEAD
      if (GetPlatform.isWeb && !controller.isRecaptchaVerified.value) {
        ui = recaptcha();
      } else if (controller.isOtpMode.value) {
        ui = otpScreen();
      } else if (controller.isPhoneLoginMode.value) {
        ui = phoneLoginScreen();
      } else {
        ui = SignInScreen(
          providers: [
            GoogleProvider(clientId: DefaultFirebaseOptions.web.apiKey),
            EmailAuthProvider(),
          ],
          showAuthActionSwitch: !controller.isRegistered,
          showPasswordVisibilityToggle: true,
          headerBuilder: LoginWidgets.headerBuilder,
          subtitleBuilder: subtitleBuilder,
          footerBuilder: (context, action) => Column(
            children: [
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.phone),
                label: const Text('Sign in with Phone'),
                onPressed: () => controller.isPhoneLoginMode.value = true,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 10),
              footerBuilder(controller.showReverificationButton, controller.credential),
            ],
          ),
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
=======
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
>>>>>>> origin/main
        showPasswordVisibilityToggle: true,
        headerBuilder: LoginWidgets.headerBuilder,
        subtitleBuilder: subtitleBuilder,
        footerBuilder: (context, action) => footerBuilder(
<<<<<<< HEAD
            controller.showReverificationButton, controller.credential),
=======
            controller.showReverificationButton, LoginController.to.credential),
>>>>>>> origin/main
        sideBuilder: LoginWidgets.sideBuilder,
        actions: getActions(),
      );
    } else {
<<<<<<< HEAD
      final thenTo = Get.rootDelegate.currentConfiguration!.currentPage!.parameters?['then'];
=======
      final thenTo = Get
          .rootDelegate.currentConfiguration!.currentPage!.parameters?['then'];
>>>>>>> origin/main
      Get.rootDelegate.offNamed(thenTo ??
          (controller.isRegistered ? Screen.HOME : Screen.REGISTER).route);
      ui = const Scaffold();
    }
    return ui;
  }

  Widget recaptcha() {
<<<<<<< HEAD
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

  Widget phoneLoginScreen() {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CountryCodePicker(
              onChanged: (country) => controller.selectedCountry.value = country,
              initialSelection: 'IN',
              favorite: ['+91', 'IN'],
            ),
            TextField(
              controller: controller.phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () => controller.sendSMSCode(
                "${controller.selectedCountry.value.dialCode}${controller.phoneController.text}",
              ),
              child: Text('Send Verification Code'),
            ),
          ],
        ),
      ),
    );
  }

  Widget otpScreen() {
    return Scaffold(
      appBar: AppBar(title: Text('Enter OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            PinCodeTextField(
              appContext: Get.context!,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
              animationDuration: Duration(milliseconds: 300),
              controller: controller.smsController,
              onCompleted: (v) => controller.verifySMSCode(v),
              onChanged: (value) {
                print(value);
              },
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
=======
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
>>>>>>> origin/main
    ];
  }
}

<<<<<<< HEAD
class EmailLinkButton extends StatelessWidget {
  final Rx<bool> show;
  final Rxn<fba.AuthCredential> credential;

  const EmailLinkButton(
      this.show,
      this.credential, {
        super.key,
      });
=======
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
>>>>>>> origin/main

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
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/main
