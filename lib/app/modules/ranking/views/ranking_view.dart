import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controllers/Ranking_Controller.dart';

class RankingView extends StatelessWidget {
  final RankingController rankingController = Get.put(RankingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top 100 Players'),
      ),
      body: Obx(() {
        if (rankingController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (rankingController.error.isNotEmpty) {
          return Center(
            child: Text(
              'Error: ${rankingController.error}',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          return ListView.builder(
            itemCount: rankingController.players.length > 100 ? 100 : rankingController.players.length,
            itemBuilder: (context, index) {
              final player = rankingController.players[index];
              return ListTile(
                leading: Text(
                  player.rank.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                title: Text(
                  player.name,
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  'Country: ${player.country} | Rating: ${player.rating}',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
