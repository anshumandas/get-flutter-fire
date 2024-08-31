import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/profile_controller.dart';
import 'package:path_provider/path_provider.dart';

class ProfileView extends StatelessWidget {
  final ProfileController _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () => _showEditDialog(context),
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        }

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FutureBuilder<File?>(
                  future: _getLocalImageFile(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                      );
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(snapshot.data!),
                      );
                    } else {
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          _controller.userData['imageUrl'] ??
                              'https://via.placeholder.com/150',
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                Text(
                  _controller.userData['name'] ?? 'No name',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  _controller.userData['email'] ?? 'No email',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                  onPressed: _controller.signOut,
                  child: Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<File?> _getLocalImageFile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String localPath = '${appDocDir.path}/user_${user.uid}.jpg';
      File localFile = File(localPath);
      if (localFile.existsSync()) {
        return localFile;
      }
    }
    return null;
  }

  void _showEditDialog(BuildContext context) {
    final nameController = TextEditingController(text: _controller.userData['name']);
    final emailController = TextEditingController(text: _controller.userData['email']);
    File? _selectedImage;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text('Edit Profile', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    _selectedImage = await _pickImage(context);
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : NetworkImage(_controller.userData['imageUrl'] ??
                        'https://via.placeholder.com/150') as ImageProvider,
                    child: Icon(Icons.camera_alt, color: Colors.white.withOpacity(0.7), size: 40),
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField(nameController, 'Name'),
                SizedBox(height: 10),
                _buildTextField(emailController, 'Email'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                _controller.updateUserData(
                  name: nameController.text,
                  email: emailController.text,
                  phoneNumber: _controller.userData['phoneNumber'] ?? '',
                  imageFile: _selectedImage,
                );
                Navigator.of(context).pop();
              },
              child: Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Future<File?> _pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
