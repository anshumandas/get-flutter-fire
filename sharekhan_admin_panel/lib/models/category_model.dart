import 'dart:convert';

class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      description: map['description'] as String,
      createdAt: map['createdAt'].toDate(),
      updatedAt: map['updatedAt'].toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CategoryModel(id: $id, name: $name, imageUrl: $imageUrl, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
}
