import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/ride_search_controller.dart';
import '../../../widgets/travel_card.dart';

class RideSearchView extends GetView<RideSearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Available Rydes',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (controller.availableRides.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(child: Text('No available rides at the moment.')),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final ride = controller.availableRides[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: TravelCard(
                        ride: ride,
                        onPressed: () => controller.acceptRide(ride.id),
                        isEditable: false,
                        isUserRide: controller.isUserRide(ride.driverId),
                      ),
                    );
                  },
                  childCount: controller.availableRides.length,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}