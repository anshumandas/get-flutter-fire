import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tasks_controller.dart';

class TasksView extends GetView<TasksController> {
  const TasksView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TasksView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TasksView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
