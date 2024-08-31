import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controllers/Ranking_Controller.dart';

class RankingView extends StatelessWidget {
  final RankingController rankingController = Get.put(RankingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (rankingController.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        } else if (rankingController.error.isNotEmpty) {
          return Center(
            child: Text(
              'Error: ${rankingController.error}',
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          );
        } else {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 350.0, // Height of the image when expanded
                floating: false,
                pinned: true,
                backgroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'assets/images/goat.png', // Replace with your image asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final player = rankingController.players[index];
                    return ListTile(
                      leading: Text(
                        player.rank.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      title: Text(
                        player.name,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Country: ${player.country} | Rating: ${player.rating}',
                        style: TextStyle(color: Colors.white70),
                      ),
                      tileColor: Colors.grey[900],
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    );
                  },
                  childCount: rankingController.players.length > 100 ? 100 : rankingController.players.length,
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
