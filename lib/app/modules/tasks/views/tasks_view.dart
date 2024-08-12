import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_flutter_fire/app/widgets/screen_widget.dart';
import 'package:get_flutter_fire/app/routes/app_pages.dart';
import '../controllers/tasks_controller.dart';

class TasksView extends GetView<TasksController> {
  const TasksView({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      body: Obx(() {
        return Column(
          children: [
            if (controller.requests.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemCount: controller.requests.length,
                itemBuilder: (context, index) {
                  final request = controller.requests[index];
                  return Dismissible(
                    key: Key(request.id),
                    background: Container(
                      color: Colors.green,
                      child: Icon(Icons.check, color: Colors.white),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: Icon(Icons.close, color: Colors.white),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                    ),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        controller.approveRequest(request['email'], index);
                      } else {
                        controller.rejectRequest(request['email'], index);
                      }
                      controller.requests.removeAt(index);
                    },
                    child: ListTile(
                      title: Text(request['email'] ?? 'Unknown'),
                      subtitle: Text('Requested upgrade to seller'),
                    ),
                  );
                },
              )
            else
              Center(
                child: Text("No Requests Found"),
              )
          ],
        );
      }),
      screen: screen!,
    );
  }
}
