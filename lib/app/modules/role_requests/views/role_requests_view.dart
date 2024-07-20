import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/role_requests_controllers.dart';

class RoleRequestsView extends GetView<RoleRequestController> {
  const RoleRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Role Requests')),
      body: Obx(() {
        if (controller.roleRequests.isEmpty) {
          return const Center(child: Text('No role requests'));
        }
        return ListView.builder(
          itemCount: controller.roleRequests.length,
          itemBuilder: (context, index) {
            final request = controller.roleRequests[index];
            return ListTile(
              title: Text('User: ${request.userId}'),
              subtitle: Text('Requested Role: ${request.requestedRole}'),
              trailing: request.approved
                  ? const Icon(Icons.check, color: Colors.green)
                  : ElevatedButton(
                      onPressed: () =>
                          controller.approveRoleRequest(request.userId),
                      child: const Text('Approve'),
                    ),
            );
          },
        );
      }),
    );
  }
}
