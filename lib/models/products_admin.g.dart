// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      image: json['image'] as String?,
      offer: json['offer'] as bool?,
      price: (json['price'] as num?)?.toDouble(),
      brand: json['brand'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'image': instance.image,
      'price': instance.price,
      'brand': instance.brand,
      'offer': instance.offer,
    };
