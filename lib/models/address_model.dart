import 'dart:convert';

class AddressModel {
  final String name;
  final String phoneNumber;
  final String line1;
  final String line2;
  final String city;
  final String district;
  final double latitude;
  final double longitude;
  final String id;
  final String userID;
  AddressModel({
    required this.name,
    required this.phoneNumber,
    required this.line1,
    required this.line2,
    required this.city,
    required this.district,
    required this.latitude,
    required this.longitude,
    required this.id,
    required this.userID,
  });

  AddressModel copyWith({
    String? name,
    String? phoneNumber,
    String? line1,
    String? line2,
    String? city,
    String? district,
    double? latitude,
    double? longitude,
    String? id,
    String? userID,
  }) {
    return AddressModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      city: city ?? this.city,
      district: district ?? this.district,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      id: id ?? this.id,
      userID: userID ?? this.userID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phoneNumber': phoneNumber,
      'line1': line1,
      'line2': line2,
      'city': city,
      'district': district,
      'latitude': latitude,
      'longitude': longitude,
      'id': id,
      'userID': userID,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      line1: map['line1'] as String,
      line2: map['line2'] as String,
      city: map['city'] as String,
      district: map['district'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      id: map['id'] as String,
      userID: map['userID'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '$line1, $line2, $district, $city';
  }
}
