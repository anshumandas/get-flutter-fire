import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/travel_card.dart';
import '../controllers/driver_dashboard_controller.dart';


class DriverDashboardView extends GetView<DriverDashboardController> {
  const DriverDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Driver Dashboard')),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Active Rides', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.activeRides.length,
              itemBuilder: (context, index) {
                final ride = controller.activeRides[index];
                TravelCard(
                  ride: ride,
                  onPressed: () => controller.completeRide(ride.id),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Pending Rides', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.pendingRides.length,
              itemBuilder: (context, index) {
                final ride = controller.pendingRides[index];
                TravelCard(
                  ride: ride,
                  onPressed: () => controller.startRide(ride.id),
                );
              },
            ),
          ],
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_RIDE),
        tooltip: 'Add New Ride',
        child: const Icon(Icons.add),
      ),
    );
  }
}