// models/categories.dart

class Category {
  final String name;

  Category({required this.name});
}

// List of categories
final List<Category> categories = [
  Category(name: 'Headphones'),
  Category(name: 'Smartphones'),
  Category(name: 'Laptops'),
  Category(name: 'Smartwatches'),
  Category(name: 'Refrigerators'),
  Category(name: 'TVs'),
];
