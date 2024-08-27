class Player {
  final String rank;
  final String name;
  final String fideId;
  final String title;
  final String country;
  final String rating;
  final String games;
  final String birthYear;

  Player({
    required this.rank,
    required this.name,
    required this.fideId,
    required this.title,
    required this.country,
    required this.rating,
    required this.games,
    required this.birthYear,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      rank: json['rank'],
      name: json['name'],
      fideId: json['fide_id'],
      title: json['title'],
      country: json['country'],
      rating: json['rating'],
      games: json['games'],
      birthYear: json['birth_year'],
    );
  }
}
