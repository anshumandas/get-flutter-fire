import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'DashboardView is working',
                  style: TextStyle(fontSize: 20),
                ),
                Text('Time: ${controller.now.value.toString()}'),
                for (final i in controller.items) Text('Time: $i'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
