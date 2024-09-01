import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailLinkAuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    initDynamicLinks();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> initDynamicLinks() async {
    // Handle link when app is in background
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      handleDynamicLink(dynamicLinkData);
    }).onError((error) {
      print('Dynamic Link Failed: ${error.message}');
    });

    // Handle link when app is opened from terminated state
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      handleDynamicLink(data);
    }
  }

  void handleDynamicLink(PendingDynamicLinkData data) {
    final Uri deepLink = data.link;
    if (deepLink.path == '/finishSignIn') {
      handleEmailSignInLink(deepLink.toString());
    }
  }

  Future<void> sendSignInLinkToEmail() async {
    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return;
    }

    isLoading.value = true;
    try {
      await _auth.sendSignInLinkToEmail(
        email: emailController.text,
        actionCodeSettings: ActionCodeSettings(
          url: 'https://yourapp.page.link/finishSignIn',
          handleCodeInApp: true,
          androidPackageName: 'com.example.yourapp',
          androidMinimumVersion: '12',
          iOSBundleId: 'com.example.yourapp',
        ),
      );
      Get.snackbar('Success', 'Check your email to complete sign in');
      // Save the email locally for later use
      await saveEmail(emailController.text);
    } catch (e) {
      Get.snackbar('Error', 'Failed to send sign in link: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleEmailSignInLink(String link) async {
    if (_auth.isSignInWithEmailLink(link)) {
      try {
        // Retrieve the email from local storage
        final email = await getSavedEmail();
        if (email == null) {
          // If email is not found, prompt the user to enter it again
          Get.toNamed('/enter-email', arguments: {'link': link});
          return;
        }

        final UserCredential userCredential = await _auth.signInWithEmailLink(
          email: email,
          emailLink: link,
        );

        if (userCredential.user != null) {
          // User is signed in
          Get.offAllNamed('/home');
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to sign in: ${e.toString()}');
      }
    }
  }

  Future<void> saveEmail(String email) async {
    // Implement this method to save email to local storage
    // For example, using shared_preferences
  }

  Future<String?> getSavedEmail() async {
    // Implement this method to retrieve email from local storage
    // For example, using shared_preferences
  }
}

class EmailLinkAuthView extends GetView<EmailLinkAuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in with Email Link')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.sendSignInLinkToEmail,
                  child: controller.isLoading.value
                      ? CircularProgressIndicator()
                      : Text('Send Sign In Link'),
                )),
          ],
        ),
      ),
    );
  }
}
