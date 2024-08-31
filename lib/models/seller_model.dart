import 'dart:convert';
import 'package:get_flutter_fire/enums/enum_parser.dart';
import 'package:get_flutter_fire/enums/enums.dart';
import 'package:get_flutter_fire/models/product_model.dart';
import 'package:get_flutter_fire/models/user_model.dart';

class SellerModel extends UserModel {
  final String sellerId;
  final List<ProductModel> products;

  SellerModel({
    required super.id,
    required super.name,
    required super.phoneNumber,
    super.email,
    required super.isBusiness,
    super.businessName,
    super.businessType,
    super.gstNumber,
    super.panNumber,
    required super.userType,
    required super.defaultAddressID,
    required super.createdAt,
    required super.lastSeenAt,
    required this.sellerId,
    required this.products,
    super.fcmTokens, // Add this line to pass the fcmTokens to the UserModel
  });

  @override
  SellerModel copyWith({
    String? sellerId,
    List<ProductModel>? products,
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
    List<String>? fcmTokens, // Add this parameter
  }) {
    return SellerModel(
      sellerId: sellerId ?? this.sellerId,
      products: products ?? this.products,
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
      fcmTokens: fcmTokens ?? this.fcmTokens, // Add this line
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'sellerId': sellerId,
      'products': products.map((product) => product.toMap()).toList(),
    });
    return map;
  }

  factory SellerModel.fromMap(Map<String, dynamic> map) {
    return SellerModel(
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
      sellerId: map['sellerId'] as String,
      products: List<ProductModel>.from(
          map['products']?.map((x) => ProductModel.fromMap(x))),
      fcmTokens:
          List<String>.from(map['fcmTokens'] as List<String>), // Add this line
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory SellerModel.fromJson(String source) =>
      SellerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SellerModel(sellerId: $sellerId, products: $products, ${super.toString()})';
  }
}
