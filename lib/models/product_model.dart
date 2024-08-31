import 'dart:convert';

class ProductModel {
  final String id;
  final String categoryID;
  final List<String> images;
  final String name;
  final String description;
  final int unitWeight;
  final int unitPrice;
  final int remainingQuantity;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String sellerId;
  final bool isSheruSpecial;
  final bool isApproved;
  ProductModel({
    required this.id,
    required this.categoryID,
    required this.images,
    required this.name,
    required this.description,
    required this.unitWeight,
    required this.unitPrice,
    required this.remainingQuantity,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.sellerId,
    required this.isSheruSpecial,
    required this.isApproved,
  });

  ProductModel copyWith({
    String? id,
    String? categoryID,
    List<String>? images,
    String? name,
    String? description,
    int? unitWeight,
    int? unitPrice,
    int? wholesalePrice,
    int? specialPrice,
    int? wholesaleQuantity,
    int? specialQuantity,
    int? remainingQuantity,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? sellerId,
    bool? isSheruSpecial,
    bool? isApproved,
  }) {
    return ProductModel(
      id: id ?? this.id,
      categoryID: categoryID ?? this.categoryID,
      images: images ?? this.images,
      name: name ?? this.name,
      description: description ?? this.description,
      unitWeight: unitWeight ?? this.unitWeight,
      unitPrice: unitPrice ?? this.unitPrice,
      remainingQuantity: remainingQuantity ?? this.remainingQuantity,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sellerId: sellerId ?? this.sellerId,
      isSheruSpecial: isSheruSpecial ?? this.isSheruSpecial,
      isApproved: isApproved ?? this.isApproved,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryID': categoryID,
      'images': images,
      'name': name,
      'description': description,
      'unitWeight': unitWeight,
      'unitPrice': unitPrice,
      'remainingQuantity': remainingQuantity,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'sellerId': sellerId,
      'isSheruSpecial': isSheruSpecial,
      'isApproved': isApproved,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      categoryID: map['categoryID'] as String,
      images: List<String>.from((map['images'])),
      name: map['name'] as String,
      description: map['description'] as String,
      unitWeight: map['unitWeight'] as int,
      unitPrice: map['unitPrice'] as int,
      remainingQuantity: map['remainingQuantity'] as int,
      isActive: map['isActive'] as bool,
      createdAt: map['createdAt'].toDate(),
      updatedAt: map['updatedAt'].toDate(),
      sellerId: map['sellerId'] as String,
      isSheruSpecial: map['isSheruSpecial'] as bool,
      isApproved: map['isApproved'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, categoryID: $categoryID, images: $images, name: $name, description: $description, unitWeight: $unitWeight, unitPrice: $unitPrice, remainingQuantity: $remainingQuantity, isActive: $isActive. createdAt: $createdAt, updatedAt: $updatedAt, sellerId: $sellerId, isSheruSpecial: $isSheruSpecial, isApproved: $isApproved)';
  }
}
