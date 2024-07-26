import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/services/remote_config.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          GetBuilder<DashboardController>(
            builder: (controller) {
              return FutureBuilder<bool>(
                future: RemoteConfig.instance.then((config) => config.showSearchBarOnTop()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || !snapshot.data!) {
                    return const SizedBox.shrink();
                  } else {
                    return GetPlatform.isMobile
                        ? IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        controller.toggleSearchBarVisibility();
                      },
                    )
                        : const SizedBox.shrink();
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        // Use the controller's state for search bar visibility
        bool isSearchBarVisible = controller.isSearchBarVisible.value;

        return FutureBuilder<bool>(
          future: RemoteConfig.instance.then((config) => config.showSearchBarOnTop()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Column(
                children: [
                  if (isSearchBarVisible)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildSearchBar(),
                    ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'DashboardView is working',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text('Time: ${controller.now.value.toString()}'),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        );
      }),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
