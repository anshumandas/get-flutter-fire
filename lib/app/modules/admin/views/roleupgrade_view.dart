import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get_flutter_fire/app/modules/admin/controllers/roleupgrade_controller.dart';

class RoleUpgradeRequestView extends GetView<RoleUpgradeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Request Role Upgrade')),
      body: Center(
        child: ElevatedButton(
          child: Text('Request Seller Role'),
          onPressed: () => controller.submitRequest('seller'),
        ),
      ),
    );
  }
}

class RoleUpgradeManagementView extends GetView<RoleUpgradeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Role Upgrade Requests')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.requests.length,
          itemBuilder: (context, index) {
            final request = controller.requests[index];
            return ListTile(
              title: Text(
                  'User ${request.userId} requests ${request.requestedRole} role'),
              subtitle: Text('Status: ${request.status}'),
              trailing: request.status == 'pending'
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () => controller.updateRequestStatus(
                              request.id, 'approved'),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => controller.updateRequestStatus(
                              request.id, 'rejected'),
                        ),
                      ],
                    )
                  : null,
            );
          },
        );
      }),
    );
  }
}
