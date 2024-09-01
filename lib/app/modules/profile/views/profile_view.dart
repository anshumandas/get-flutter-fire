import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../../../models/screens.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(
                '${controller.currentUser.value?.displayName ?? "User"} Profile'),
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildProfileImage(),
              const SizedBox(height: 20),
              _buildInfoTile(
                  'Email', controller.currentUser.value?.email ?? 'Not set'),
              _buildInfoTile('Phone',
                  controller.currentUser.value?.phoneNumber ?? 'Not verified'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.toNamed(Screen.PHONE_VERIFICATION.route),
                child: Text(controller.currentUser.value?.phoneNumber != null
                    ? 'Update Phone Number'
                    : 'Verify Phone Number'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.logout,
                child: const Text('Logout'),
              ),
              ElevatedButton(
                onPressed: () => Get.toNamed(Screen.TWO_FACTOR_AUTH.route),
                child: Text('Set up Two-Factor Authentication'),
              ),
              ElevatedButton(
                child: Text('Request Role Upgrade'),
                onPressed: () => Get.toNamed('/role-upgrade-request'),
              ),
            ],
          ),
        ));
  }

  Widget _buildProfileImage() {
    return Center(
      child: CircleAvatar(
        radius: 50,
        backgroundImage: controller.photoURL != null
            ? NetworkImage(controller.photoURL!)
            : null,
        child: controller.photoURL == null
            ? const Icon(Icons.person, size: 50)
            : null,
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
    );
  }
}
