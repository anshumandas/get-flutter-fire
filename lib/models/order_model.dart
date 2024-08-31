import 'dart:convert';
import 'package:get_flutter_fire/enums/enum_parser.dart';
import 'package:get_flutter_fire/enums/enums.dart';
import 'package:get_flutter_fire/models/address_model.dart';

class OrderModel {
  final String id;
  final List<ProductData> products;
  final double totalWeight;
  final int totalPrice;
  final String userID;
  final AddressModel address;
  final List<OrderStatusUpdate> statusUpdates;
  final OrderStatus currentStatus;
  final String paymentMethod;
  final DateTime createdAt;
  final String couponID;
  final int couponDiscount;
  OrderModel({
    required this.id,
    required this.products,
    required this.totalWeight,
    required this.totalPrice,
    required this.userID,
    required this.address,
    required this.statusUpdates,
    required this.currentStatus,
    required this.paymentMethod,
    required this.createdAt,
    required this.couponID,
    required this.couponDiscount,
  });

  OrderModel copyWith({
    String? id,
    List<ProductData>? products,
    double? totalWeight,
    int? totalPrice,
    String? userID,
    AddressModel? address,
    List<OrderStatusUpdate>? statusUpdates,
    OrderStatus? currentStatus,
    String? paymentMethod,
    DateTime? createdAt,
    String? couponID,
    int? couponDiscount,
  }) {
    return OrderModel(
      id: id ?? this.id,
      products: products ?? this.products,
      totalWeight: totalWeight ?? this.totalWeight,
      totalPrice: totalPrice ?? this.totalPrice,
      userID: userID ?? this.userID,
      address: address ?? this.address,
      statusUpdates: statusUpdates ?? this.statusUpdates,
      currentStatus: currentStatus ?? this.currentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      couponID: couponID ?? this.couponID,
      couponDiscount: couponDiscount ?? this.couponDiscount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'totalWeight': totalWeight,
      'totalPrice': totalPrice,
      'userID': userID,
      'address': address.toMap(),
      'statusUpdates': statusUpdates.map((x) => x.toMap()).toList(),
      'currentStatus': currentStatus.name,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt,
      'couponID': couponID,
      'couponDiscount': couponDiscount,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      products: List<ProductData>.from(
        (map['products'] as List<dynamic>).map<ProductData>(
          (x) => ProductData.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalWeight: map['totalWeight'] as double,
      totalPrice: map['totalPrice'] as int,
      userID: map['userID'] as String,
      address: AddressModel.fromMap(map['address'] as Map<String, dynamic>),
      statusUpdates: List<OrderStatusUpdate>.from(
        (map['statusUpdates'] as List<dynamic>).map<OrderStatusUpdate>(
          (x) => OrderStatusUpdate.fromMap(x as Map<String, dynamic>),
        ),
      ),
      currentStatus: parseOrderStatus(map['currentStatus'] as String),
      paymentMethod: map['paymentMethod'] as String,
      createdAt: map['createdAt'].toDate(),
      couponID: map['couponID'] as String,
      couponDiscount: map['couponDiscount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, products: $products, totalWeight: $totalWeight, totalPrice: $totalPrice, userID: $userID, address: $address, statusUpdates: $statusUpdates, currentStatus: $currentStatus, paymentMethod: $paymentMethod, createdAt: $createdAt, couponID: $couponID, couponDiscount: $couponDiscount)';
  }
}

class ProductData {
  final String id;
  final int price;
  final int quantity;
  ProductData({
    required this.id,
    required this.price,
    required this.quantity,
  });

  ProductData copyWith({
    String? id,
    int? price,
    int? priceRrp,
    int? quantity,
  }) {
    return ProductData(
      id: id ?? this.id,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'quantity': quantity,
    };
  }

  factory ProductData.fromMap(Map<String, dynamic> map) {
    return ProductData(
      id: map['id'] as String,
      price: map['price'] as int,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductData.fromJson(String source) =>
      ProductData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductData(id: $id, price: $price, quantity: $quantity)';
  }
}

class OrderStatusUpdate {
  final OrderStatus status;
  final DateTime timestamp;
  OrderStatusUpdate({
    required this.status,
    required this.timestamp,
  });

  OrderStatusUpdate copyWith({
    OrderStatus? status,
    DateTime? timestamp,
  }) {
    return OrderStatusUpdate(
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status.name,
      'timestamp': timestamp,
    };
  }

  factory OrderStatusUpdate.fromMap(Map<String, dynamic> map) {
    return OrderStatusUpdate(
      status: parseOrderStatus(map['status'] as String),
      timestamp: map['timestamp'].toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStatusUpdate.fromJson(String source) =>
      OrderStatusUpdate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Status(status: $status, timestamp: $timestamp)';
}
