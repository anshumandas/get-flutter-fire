import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/active_ride_controller.dart';

class ActiveRideView extends GetView<ActiveRideController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Active Ride')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (!controller.hasLocationPermission.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Location permission is required to use this feature.'),
                ElevatedButton(
                  onPressed: () => controller.onInit(),
                  child: Text('Request Permission'),
                ),
              ],
            ),
          );
        } else if (controller.activeRide.value == null) {
          return Center(child: Text('No active ride'));
        } else {
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    controller.currentLocation.value?.latitude ?? 0,
                    controller.currentLocation.value?.longitude ?? 0,
                  ),
                  zoom: 14.0,
                ),
                onMapCreated: controller.onMapCreated,
                markers: controller.markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Status: ${controller.activeRide.value!.tripStatus}'),
                        Text('Pickup: ${controller.activeRide.value!.pickupLocation}'),
                        Text('Destination: ${controller.activeRide.value!.destination}'),
                        SizedBox(height: 16),
                        Text('Is Driver: ${controller.isDriver.value}'), // Debug text
                        if (controller.isDriver.value) ...[
                          _buildDriverButtons(),
                        ] else
                          _buildRiderButtons(),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: controller.navigateToGoogleMaps,
                          child: Text('Navigate'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget _buildDriverButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (controller.activeRide.value!.tripStatus == 'Accepted')
          ElevatedButton(
            onPressed: controller.startRide,
            child: Text('Start Ride'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
        if (controller.activeRide.value!.tripStatus == 'InProgress')
          ElevatedButton(
            onPressed: controller.completeRide,
            child: Text('Complete Ride'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: controller.cancelRide,
          child: Text('Cancel Ride'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
      ],
    );
  }

  Widget _buildRiderButtons() {
    return ElevatedButton(
      onPressed: controller.cancelRide,
      child: Text('Cancel Ride'),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
    );
  }
}