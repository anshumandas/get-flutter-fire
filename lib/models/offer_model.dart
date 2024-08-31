import 'dart:convert';

class OfferModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String city;
  final DateTime validFrom;
  final DateTime validTo;

  OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.city,
    required this.validFrom,
    required this.validTo,
  });

  OfferModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? city,
    DateTime? validFrom,
    DateTime? validTo,
  }) {
    return OfferModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      city: city ?? this.city,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'city': city,
      'validFrom': validFrom.toIso8601String(),
      'validTo': validTo.toIso8601String(),
    };
  }

  factory OfferModel.fromMap(Map<String, dynamic> map) {
    return OfferModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      city: map['city'] as String,
      validFrom: DateTime.parse(map['validFrom'] as String),
      validTo: DateTime.parse(map['validTo'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory OfferModel.fromJson(String source) =>
      OfferModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OfferModel(id: $id, title: $title, description: $description, imageUrl: $imageUrl, city: $city, validFrom: $validFrom, validTo: $validTo)';
  }
}
