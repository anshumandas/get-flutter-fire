import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modules/home/controllers/Ranking_Controller.dart';

class RankingWidget extends StatelessWidget {
  final RankingController rankingController = Get.put(RankingController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
          shrinkWrap: true, // Important for nesting in a scrollable view
          physics: NeverScrollableScrollPhysics(), // Disable scrolling for the widget itself
          itemCount: rankingController.players.length,
          itemBuilder: (context, index) {
            final player = rankingController.players[index];
            return ListTile(
              leading: Text(player.rank,
                style: TextStyle(color: Colors.white)),
              title: Text(player.name,
              style: TextStyle(color: Colors.white),),
              subtitle: Text('Country: ${player.country} | Rating: ${player.rating}',
                style:TextStyle(color: Colors.white) ,),
            );
          },
        );
      }
    });
  }
}
