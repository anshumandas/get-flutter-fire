import 'package:flutter/material.dart';
import '../../services/Streamer.dart';

class CardWidget extends StatelessWidget {
  final Streamer streamer;
  final VoidCallback onTap;

  CardWidget({
    required this.streamer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        // Reduced width to make the card smaller
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6.0,
              spreadRadius: 2.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.network(
                streamer.avatar,
                height: 100, // Reduced height to match smaller card
                width: double.infinity,
                fit: BoxFit.cover, // Zoom out the image to improve quality
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 100,
                    color: Colors.grey[300],
                    child: Icon(Icons.error, color: Colors.red),
                  );
                },
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: progress.expectedTotalBytes != null
                            ? progress.cumulativeBytesLoaded /
                            (progress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Headline
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                streamer.username,
                style: TextStyle(
                  fontSize: 14, // Reduced font size to match smaller card
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Live Indicator (Optional)
            if (streamer.isLive)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.live_tv, color: Colors.red, size: 14), // Reduced icon size
                    SizedBox(width: 4),
                    Text(
                      'Live',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
