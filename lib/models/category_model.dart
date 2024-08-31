import 'dart:convert';

class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;
  final String? bannerImageUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.bannerImageUrl, // Make this field nullable
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? bannerImageUrl,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      bannerImageUrl: bannerImageUrl ?? this.bannerImageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'bannerImageUrl': bannerImageUrl,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      bannerImageUrl: map['bannerImageUrl'] as String?, // Safely handle null
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CategoryModel(id: $id, name: $name, imageUrl: $imageUrl, bannerImageUrl: $bannerImageUrl)';
}
