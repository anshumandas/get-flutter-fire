class Product {
  final String id;
  final String name;
  final String brandName;
  final String category;
  final String productImage;
  // final String description;
  final double price;
  // final double sellingPrice;

  Product({
    required this.id,
    required this.name,
    required this.brandName,
    required this.category,
    required this.productImage,
    // required this.description,
    required this.price,
    // required this.sellingPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '',
      name: json['productName'] ?? 'No Name',
      brandName: json['brandName'] as String? ?? 'No Brand Name',
      category: json['category'] ?? 'No Category',
      productImage: json['productImage'][0] ?? "",
      // description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      // sellingPrice: (json['sellingPrice'] ?? 0).toDouble(),
    );
  }
}

