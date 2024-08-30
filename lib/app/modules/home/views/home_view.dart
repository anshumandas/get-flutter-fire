import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../ride_search/views/ride_search_view.dart';
import '../../add_ride/views/add_ride_view.dart';
import '../../past_rides/views/past_rides_view.dart';
import '../../settings/views/settings_view.dart';
import '../../active_ride/views/active_ride_view.dart'; // Import ActiveRideView

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.currentIndex.value) {
          case 0:
            return RideSearchView();
          case 1:
            return AddRidesView();
          case 2:
            return PastRidesView();
          case 3:
            return ActiveRideView(); // New Active Ride tab
          case 4:
            return SettingsView();
          default:
            return RideSearchView();
        }
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changePage,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Ride'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Past Rides'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Active Ride'), // New tab
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      )),
    );
  }
}
