import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => CircleAvatar(
              radius: 50,
              backgroundImage: controller.profileImageController.imageUrl.isNotEmpty
                  ? NetworkImage(controller.profileImageController.imageUrl)
                  : null,
              child: controller.profileImageController.imageUrl.isEmpty
                  ? Icon(Icons.person, size: 50)
                  : null,
            )),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _showImageSourceActionSheet(context),
              child: Text('Change Profile Picture'),
            ),
            SizedBox(height: 16),
            Obx(() => Text('Email: ${controller.email.value}')),
            SizedBox(height: 16),
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.updateProfile,
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
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
                  controller.profileImageController.pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  controller.profileImageController.pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}