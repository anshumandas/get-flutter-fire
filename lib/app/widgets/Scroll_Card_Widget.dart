import 'package:flutter/material.dart';
import '../../services/Streamer.dart';
import 'Card_Widget.dart'; // Import your Streamer model
import 'package:url_launcher/url_launcher.dart';


class ScrollCardWidget extends StatelessWidget {
  final List<Streamer> streamers; // List of Streamer models

  ScrollCardWidget({required this.streamers});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190, // Adjust height based on CardWidget height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: streamers.length,
        itemBuilder: (context, index) {
          return CardWidget(
            streamer: streamers[index], // Pass Streamer object
            onTap: () {
              _showPopup(context, streamers[index]); // Handle card tap
            },
          );
        },
      ),
    );
  }

  void _showPopup(BuildContext context, Streamer streamer) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(streamer.username),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(streamer.avatar, height: 100, width: 100),
              SizedBox(height: 10),
              Text("Username: ${streamer.username}"),
              Text("Live: ${streamer.isLive ? 'Yes' : 'No'}"),
              Text("Community Streamer: ${streamer.isCommunityStreamer
                  ? 'Yes'
                  : 'No'}"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _launchURL(context, streamer.twitchUrl); // Redirect to Twitch
                },
                child: Text('Checkout Stream'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _launchURL(BuildContext context, String urlString) async {
    Uri url = Uri.parse(urlString);
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $urlString: $e')),
      );
    }
  }
}