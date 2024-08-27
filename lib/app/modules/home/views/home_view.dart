import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/widgets/Vs_Widget.dart';
import '../../../widgets/Scroll_Card_Widget.dart';
import '../../../widgets/Ranking_Widget.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.35,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/ding.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Featured Streamers',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      } else if (controller.error.isNotEmpty) {
                        return Center(
                          child: Text(
                            'Error: ${controller.error}',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (controller.streamers.isEmpty) {
                        return Center(
                          child: Text(
                            'No streamers found',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else {
                        return ScrollCardWidget(streamers: controller.streamers);
                      }
                    }),
                    SizedBox(height: 40,),
                    Text(
                      'World Championship',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    VsWidget(
                        imageUrl1: 'assets/images/ding.jpg',
                        imageUrl2: 'assets/images/gukesh.jpg',
                        label1: 'Ding liren',
                        label2: 'Gukesh D'),
                    SizedBox(height: 40),
                    Text(
                      'Top 10 Players',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RankingWidget(numberOfPlayers: 10,), // Add the RankingWidget here
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.snackbar('Action', 'Floating action button pressed', snackPosition: SnackPosition.BOTTOM);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
