import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/past_ryde_card.dart';
import '../controllers/past_rides_controller.dart';


class PastRidesView extends GetView<PastRidesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Past Rides')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.pastRides.isEmpty) {
          return const Center(child: Text('No past rides found'));
        } else {
          return ListView.builder(
            itemCount: controller.pastRides.length,
            itemBuilder: (context, index) {
              final ride = controller.pastRides[index];
              return PastRideCard(ride: ride);
            },
          );
        }
      }),
    );
  }
}