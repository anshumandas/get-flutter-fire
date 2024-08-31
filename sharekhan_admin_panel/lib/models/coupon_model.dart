import 'dart:convert';

class CouponModel {
  final String id;
  final String couponCode;
  final String description;
  final double percentage;
  final int maxAmount;
  final List<String> userIDs;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  CouponModel({
    required this.id,
    required this.couponCode,
    required this.description,
    required this.percentage,
    required this.maxAmount,
    required this.userIDs,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  CouponModel copyWith({
    String? id,
    String? couponCode,
    String? description,
    double? percentage,
    int? maxAmount,
    List<String>? userIDs,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CouponModel(
      id: id ?? this.id,
      couponCode: couponCode ?? this.couponCode,
      description: description ?? this.description,
      percentage: percentage ?? this.percentage,
      maxAmount: maxAmount ?? this.maxAmount,
      userIDs: userIDs ?? this.userIDs,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'couponCode': couponCode,
      'description': description,
      'percentage': percentage,
      'maxAmount': maxAmount,
      'userIDs': userIDs,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory CouponModel.fromMap(Map<String, dynamic> map) {
    return CouponModel(
      id: map['id'] as String,
      couponCode: map['couponCode'] as String,
      description: map['description'] as String,
      percentage: map['percentage'] as double,
      maxAmount: map['maxAmount'] as int,
      userIDs: List<String>.from((map['userIDs'])),
      isActive: map['isActive'] as bool,
      createdAt: map['createdAt'].toDate(),
      updatedAt: map['updatedAt'].toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CouponModel.fromJson(String source) =>
      CouponModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CouponModel(id: $id, couponCode: $couponCode, description: $description, percentage: $percentage, maxAmount: $maxAmount, userIDs: $userIDs, isActive: $isActive , createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
