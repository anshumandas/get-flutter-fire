import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../profileimage/profileimage_controller.dart';
import '../controller/singup_controller.dart';

class SignupView extends GetView<SignupController> {
  final ProfileImageController profileImageController = Get.put(ProfileImageController());

  @override
  Widget build(BuildContext context) {
    // Get the wasGuest value from the arguments
    final bool wasGuest = Get.arguments?['wasGuest'] ?? false;
    
    // Set the wasGuest value in the controller
    controller.wasGuest.value = wasGuest;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Obx(() => CircleAvatar(
                radius: 50,
                backgroundImage: profileImageController.imageUrl.isNotEmpty
                    ? NetworkImage(profileImageController.imageUrl)
                    : null,
                child: profileImageController.imageUrl.isEmpty
                    ? Icon(Icons.person, size: 50)
                    : null,
              )),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _showImageSourceActionSheet(context),
                child: Text('Pick Profile Image'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: controller.passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.signup,
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    if (GetPlatform.isIOS || GetPlatform.isAndroid) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Photo Library'),
                  onTap: () {
                    profileImageController.pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    profileImageController.pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Select Image Source'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  profileImageController.pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
                child: Text('Photo Library'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  profileImageController.pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
                child: Text('Camera'),
              ),
            ],
          );
        },
      );
    }
  }
}