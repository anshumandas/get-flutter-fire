import 'dart:convert';

class CartModel {
  List<CartItem> items;
  final String id;

  CartModel({
    required this.items,
    required this.id,
  });

  int get itemCount => items.length;

  CartModel copyWith({
    List<CartItem>? items,
    String? id,
  }) {
    return CartModel(
      items: items ?? this.items,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'items': items.map((x) => x.toMap()).toList(),
      'id': id,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      items: List<CartItem>.from(
        map['items']?.map((x) => CartItem.fromMap(x as Map<String, dynamic>)) ??
            [],
      ),
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Cart(items: $items, id: $id)';
}

class CartItem {
  String id;
  final int price;
  int quantity;
  CartItem({
    required this.id,
    required this.price,
    required this.quantity,
  });

  CartItem copyWith({
    String? id,
    int? price,
    int? quantity,
  }) {
    return CartItem(
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

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String,
      price: map['price'] as int,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartItem(id: $id, price: $price, quantity: $quantity)';
  }
}
