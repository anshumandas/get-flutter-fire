import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MySearchController extends GetxController {
  var playerDetails = <String, dynamic>{}.obs;
  var history = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> performSearch(String query) async {
    if (query.isNotEmpty) {
      isLoading.value = true;
      errorMessage.value = '';
      final url = Uri.parse('https://fide-api.vercel.app/player_info/?fide_id=$query&history=true');

      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data != null && data is Map<String, dynamic>) {
            playerDetails.value = {
              "fide_id": data['fide_id'] ?? 'N/A',
              "fide_title": data['fide_title'] ?? 'N/A',
              "federation": data['federation'] ?? 'N/A',
              "birth_year": data['birth_year'] ?? 'N/A',
              "sex": data['sex'] ?? 'N/A',
              "name": data['name'] ?? 'N/A',
              "world_rank_all": data['world_rank_all'] ?? 'N/A',
              "world_rank_active": data['world_rank_active'] ?? 'N/A',
              "continental_rank_all": data['continental_rank_all'] ?? 'N/A',
              "continental_rank_active": data['continental_rank_active'] ?? 'N/A',
              "national_rank_all": data['national_rank_all'] ?? 'N/A',
              "national_rank_active": data['national_rank_active'] ?? 'N/A',
            };
            history.value = (data['history'] as List<dynamic>?)
                ?.map((item) => item as Map<String, dynamic>)
                .toList() ?? [];
          } else {
            errorMessage.value = 'Unexpected data format.';
          }
        } else {
          errorMessage.value = 'Error: ${response.statusCode}';
        }
      } catch (e) {
        errorMessage.value = 'Error: $e';
      } finally {
        isLoading.value = false;
      }
    }
  }
}
