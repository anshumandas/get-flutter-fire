class Product {
  final String id;
  final String name;
  final double price;
  final String productImage;
  final String brandName;
  final String category;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.productImage,
    required this.brandName,
    required this.category,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'productImage': productImage,
      'brandName': brandName,
      'category': category,
      'description': description,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      productImage: json['productImage'],
      brandName: json['brandName'],
      category: json['category'],
      description: json['description'],
    );
  }
}