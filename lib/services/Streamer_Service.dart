import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Streamer.dart';

class StreamerService {
  static const String _url = 'https://api.chess.com/pub/streamers';

  Future<List<Streamer>> fetchStreamers() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      // Decode the JSON data
      final data = json.decode(response.body);
      // Map the JSON to a list of Streamer objects
      return (data['streamers'] as List)
          .map((streamerJson) => Streamer.fromJson(streamerJson))
          .toList();
    } else {
      throw Exception('Failed to load streamers');
    }
  }
}
