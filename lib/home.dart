import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'image_controller.dart'; // Import ImageController
import 'image_uploads.dart'; // Import ImageUploads
import 'change_password_screen.dart'; // Import ChangePasswordScreen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageController imageController = Get.find<ImageController>();
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        actions: [
          MenuAnchor(
            builder: (context, controller, child) {
              return IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  controller.open();
                },
              );
            },
            menuChildren: [
              MenuItemButton(
                onPressed: () {
                  // Check if the user is logged in anonymously
                  if (user != null && user.isAnonymous) {
                    _showCreateAccountDialog(context);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute<ProfileScreen>(
                        builder: (context) => ProfileScreen(
                          appBar: AppBar(
                            title: const Text('User Profile'),
                          ),
                          actions: [
                            SignedOutAction((context) {
                              Navigator.of(context).pop();
                            })
                          ],
                          children: [
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset('flutterfire_300x.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Profile'),
              ),
              MenuItemButton(
                onPressed: () {
                  // Check if the user is logged in anonymously
                  if (user != null && user.isAnonymous) {
                    _showCreateAccountDialog(context);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen(),
                      ),
                    );
                  }
                },
                child: const Text('Change Password'),
              ),
              MenuItemButton(
                onPressed: () {
                  FirebaseUIAuth.signOut();
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              return Container(
                height: MediaQuery.of(context).size.height / 3.2,
                width: MediaQuery.of(context).size.width / 1.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageController.files.isNotEmpty
                        ? FileImage(imageController.files.first)
                        : const AssetImage('lib/assets/images/dash.png') as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    width: 0.0,
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.zero,
                ),
              );
            }),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Check if the user is logged in anonymously
                if (user != null && user.isAnonymous) {
                  _showCreateAccountDialog(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageUploads(),
                    ),
                  );
                }
              },
              child: const Text("Go to Upload Screen"),
            ),
            SizedBox(height: 32),
            Text(
              'Welcome!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SignOutButton(),
          ],
        ),
      ),
    );
  }

  void _showCreateAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create an Account'),
          content: const Text('You are currently logged in anonymously. Please create an account to access this feature.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Redirect to the sign-up screen or process account creation
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      appBar: AppBar(
                        title: const Text('Create Account'),
                      ),
                      children: [
                        // Your account creation widget here
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Create Account'),
            ),
          ],
        );
      },
    );
  }
}
