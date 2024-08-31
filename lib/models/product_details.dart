class Product {
  final String id;
  final String name;
  final String location;
  final double price;
  final String imageAsset;
  final String description;
  final List<String> additionalImages; // Additional images


  Product ({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.imageAsset,
    required this.description,
    required this.additionalImages,

  });
}