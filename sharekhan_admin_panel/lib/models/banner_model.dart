import 'dart:convert';

class BannerModel {
  final String id;
  final String imageUrl;
  final String productID;
  final bool isActive;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  BannerModel({
    required this.id,
    required this.imageUrl,
    required this.productID,
    required this.isActive,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  BannerModel copyWith({
    String? id,
    String? imageUrl,
    String? productID,
    bool? isActive,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BannerModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      productID: productID ?? this.productID,
      isActive: isActive ?? this.isActive,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
      'productID': productID,
      'isActive': isActive,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
      productID: map['productID'] as String,
      isActive: map['isActive'] as bool,
      description: map['description'] as String,
      createdAt: map['createdAt'].toDate(),
      updatedAt: map['updatedAt'].toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BannerModel(id: $id, imageUrl: $imageUrl, productID: $productID, isActive: $isActive, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
