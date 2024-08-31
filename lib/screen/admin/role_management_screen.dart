import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:your_app/services/role_service.dart';

import '../../services/role_service.dart';

class RoleManagementScreen extends StatelessWidget {
  final RoleService roleService = Get.find<RoleService>();
  final uidController = TextEditingController();
  final roleController = TextEditingController();

  RoleManagementScreen({super.key});

  void assignRole() async {
    await roleService.setUserRole(uidController.text, roleController.text);
    Get.snackbar('Success', 'Role assigned successfully!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Role Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: uidController,
              decoration: const InputDecoration(labelText: 'User UID'),
            ),
            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: 'Role'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: assignRole,
              child: const Text('Assign Role'),
            ),
          ],
        ),
      ),
    );
  }
}
