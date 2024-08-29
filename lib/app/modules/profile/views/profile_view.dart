import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/profile_controller.dart';

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

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  _controller.userData['imageUrl'] ?? 'https://via.placeholder.com/150',
                ),
              ),
              SizedBox(height: 20),
              Text(
                _controller.userData['name'] ?? 'No name',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                _controller.userData['email'] ?? 'No email',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                onPressed: _controller.signOut,
                child: Text('Sign Out', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showEditDialog(BuildContext context) {
    final nameController = TextEditingController(text: _controller.userData['name']);
    final emailController = TextEditingController(text: _controller.userData['email']);
    final imageController = TextEditingController(text: _controller.userData['imageUrl']);

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
                  onTap: () => _pickImage(context, imageController),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: imageController.text.isEmpty
                        ? NetworkImage('https://via.placeholder.com/150')
                        : NetworkImage(imageController.text),
                    child: Icon(Icons.camera_alt, color: Colors.white.withOpacity(0.7), size: 40),
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField(nameController, 'Name'),
                SizedBox(height: 10),
                _buildTextField(emailController, 'Email'),
                SizedBox(height: 10),
                _buildTextField(imageController, 'Image URL'),
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
                  imageUrl: imageController.text,
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

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context, TextEditingController imageController) async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Upload image to a cloud storage service (e.g., Firebase Storage)
      // and update the URL in Firestore
      // For this example, just updating the local text field
      imageController.text = pickedFile.path;
    }
  }
}
