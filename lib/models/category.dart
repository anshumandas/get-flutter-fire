class Category {
  final String id;
  final String name;
  final String? description;
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    this.description,
    required this.imageUrl,
  });

  factory Category.fromMap(Map<String, dynamic> map, String id) {
    return Category(
      id: id,
      name: map['name'] ?? '',
      description: map['description'],
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
