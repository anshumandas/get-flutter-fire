import 'dart:convert';

class BannerModel {
  final String id;
  final String imageUrl;
  final String productID;
  final bool isActive;
  BannerModel({
    required this.id,
    required this.imageUrl,
    required this.productID,
    required this.isActive,
  });

  BannerModel copyWith({
    String? id,
    String? imageUrl,
    String? productID,
    bool? isActive,
  }) {
    return BannerModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      productID: productID ?? this.productID,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
      'productID': productID,
      'isActive': isActive,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
      productID: map['productID'] as String,
      isActive: map['isActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BannerModel(id: $id, imageUrl: $imageUrl, productID: $productID, isActive: $isActive)';
  }
}
