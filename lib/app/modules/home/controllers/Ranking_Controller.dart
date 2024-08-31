import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../services/player.dart';

class RankingController extends GetxController {
  var players = <Player>[].obs;
  var isLoading = true.obs;
  var error = ''.obs;

  @override
  void onInit() {
    fetchTopPlayers();
    super.onInit();
  }

  void fetchTopPlayers() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://fide-api.vercel.app/top_players'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        players.value = jsonResponse.map((player) => Player.fromJson(player)).toList();
      } else {
        error('Failed to load data');
      }
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
