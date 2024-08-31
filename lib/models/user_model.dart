import 'dart:convert';
import 'package:get_flutter_fire/enums/enum_parser.dart';
import 'package:get_flutter_fire/enums/enums.dart';

class UserModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String? email;
  final bool isBusiness;
  final String? businessName;
  final String? businessType;
  final String? gstNumber;
  final String? panNumber;
  final UserType userType;
  final String defaultAddressID;
  final DateTime createdAt;
  final DateTime lastSeenAt;
  final List<String> fcmTokens;

  UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.email,
    required this.isBusiness,
    this.businessName,
    this.businessType,
    this.gstNumber,
    this.panNumber,
    required this.userType,
    required this.defaultAddressID,
    required this.createdAt,
    required this.lastSeenAt,
    this.fcmTokens = const [],
  });

  get role => null;

  UserModel copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    bool? isBusiness,
    String? businessName,
    String? businessType,
    String? gstNumber,
    String? panNumber,
    UserType? userType,
    String? defaultAddressID,
    DateTime? createdAt,
    DateTime? lastSeenAt,
    List<String>? fcmTokens,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      isBusiness: isBusiness ?? this.isBusiness,
      businessName: businessName ?? this.businessName,
      businessType: businessType ?? this.businessType,
      gstNumber: gstNumber ?? this.gstNumber,
      panNumber: panNumber ?? this.panNumber,
      userType: userType ?? this.userType,
      defaultAddressID: defaultAddressID ?? this.defaultAddressID,
      createdAt: createdAt ?? this.createdAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      fcmTokens: fcmTokens ?? this.fcmTokens,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'isBusiness': isBusiness,
      'businessName': businessName,
      'businessType': businessType,
      'gstNumber': gstNumber,
      'panNumber': panNumber,
      'userType': userType.name,
      'defaultAddressID': defaultAddressID,
      'createdAt': createdAt.toIso8601String(),
      'lastSeenAt': lastSeenAt.toIso8601String(),
      'fcmTokens': fcmTokens
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      isBusiness: map['isBusiness'] as bool,
      businessName:
          map['businessName'] != null ? map['businessName'] as String : null,
      businessType:
          map['businessType'] != null ? map['businessType'] as String : null,
      gstNumber: map['gstNumber'] != null ? map['gstNumber'] as String : null,
      panNumber: map['panNumber'] != null ? map['panNumber'] as String : null,
      userType: parseUserType(map['userType'] as String),
      defaultAddressID: map['defaultAddressID'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      lastSeenAt: DateTime.parse(map['lastSeenAt'] as String),
      fcmTokens: map['fcmTokens'] != null
          ? List<String>.from(map['fcmTokens'] as List)
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, phoneNumber: $phoneNumber, email: $email, isBusiness: $isBusiness, businessName: $businessName, businessType: $businessType, gstNumber: $gstNumber, panNumber: $panNumber, userType: $userType, defaultAddressID: $defaultAddressID, createdAt: $createdAt, lastSeenAt: $lastSeenAt, fcmTokens: $fcmTokens)';
  }
}
