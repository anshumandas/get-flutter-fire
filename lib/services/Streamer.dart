class Streamer {
  final String username;
  final String avatar;
  final String twitchUrl;
  final String url;
  final bool isLive;
  final bool isCommunityStreamer;
  final List<String> platforms;

  Streamer({
    required this.username,
    required this.avatar,
    required this.twitchUrl,
    required this.url,
    required this.isLive,
    required this.isCommunityStreamer,
    required this.platforms,
  });

  factory Streamer.fromJson(Map<String, dynamic> json) {
    return Streamer(
      username: json['username'] ?? '', // Default to empty string if null
      avatar: json['avatar'] ?? '', // Default to empty string if null
      twitchUrl: json['twitch_url'] ?? '', // Default to empty string if null
      url: json['url'] ?? '', // Default to empty string if null
      isLive: json['is_live'] ?? false, // Default to false if null
      isCommunityStreamer: json['is_community_streamer'] ?? false, // Default to false if null
      platforms: json['platforms'] != null
          ? List<String>.from(json['platforms'])
          : [], // Default to empty list if null
    );
  }
}
