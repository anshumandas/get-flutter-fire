class Product {
  final String id;
  final String name;
  final String brandName;
  final String category;
  final String productImage;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.brandName,
    required this.category,
    required this.productImage,
    required this.price,
  });

  /// Factory constructor for creating a `Product` instance from a JSON map
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      brandName: json['brandName'] as String,
      category: json['category'] as String,
      productImage: json['productImage'] as String,
      price:
          (json['price'] as num).toDouble(), // To ensure the price is a double
    );
  }

  /// Method to convert a `Product` instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brandName': brandName,
      'category': category,
      'productImage': productImage,
      'price': price,
    };
  }

  /// Method for creating a copy of the current `Product` instance with modified fields
  Product copyWith({
    String? id,
    String? name,
    String? brandName,
    String? category,
    String? productImage,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      brandName: brandName ?? this.brandName,
      category: category ?? this.category,
      productImage: productImage ?? this.productImage,
      price: price ?? this.price,
    );
  }

  /// Override `toString` for better debugging
  @override
  String toString() {
    return 'Product{id: $id, name: $name, brandName: $brandName, category: $category, productImage: $productImage, price: $price}';
  }

  /// Override `==` and `hashCode` to compare products by their fields
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.brandName == brandName &&
        other.category == category &&
        other.productImage == productImage &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        brandName.hashCode ^
        category.hashCode ^
        productImage.hashCode ^
        price.hashCode;
  }
}
