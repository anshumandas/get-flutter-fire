class Category {
  String id;
  String name;
  List<Category> subCategories;

  Category(
      {required this.id, required this.name, this.subCategories = const []});

  factory Category.fromMap(Map<String, dynamic> data) {
    return Category(
      id: data['id'],
      name: data['name'],
      subCategories: (data['subCategories'] as List)
          .map((subCat) => Category.fromMap(subCat))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'subCategories': subCategories.map((subCat) => subCat.toMap()).toList(),
    };
  }
}
