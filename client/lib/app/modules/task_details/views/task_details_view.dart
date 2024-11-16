import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/task_details_controller.dart';

class TaskDetailsView extends GetView<TaskDetailsController> {
  const TaskDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskDetailsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TaskDetailsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
