import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/cart_controller.dart';
import 'package:get_flutter_fire/app/modules/categories/controllers/categories_controller.dart';
import 'package:get_flutter_fire/app/routes/app_pages.dart';
import 'package:get_flutter_fire/app/widgets/custom_widgets.dart';
import 'package:get_flutter_fire/models/product.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  ProductsView({Key? key}) : super(key: key);

  final CategoriesController categoriesController =
      Get.find<CategoriesController>();
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Get.toNamed('/cart'),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryBar(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.products.isEmpty) {
                return const Center(child: Text('No products available'));
              }
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return ProductCard(
                    product: product,
                    onAddToCart: (product, quantity) =>
                        cartController.addToCart(product, quantity),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBar() {
    return Container(
      height: 50,
      child: Obx(() {
        if (categoriesController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoriesController.categories.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildCategoryChip(
                  'All', '', controller.selectedCategoryId.value.isEmpty);
            }
            final category = categoriesController.categories[index - 1];
            return _buildCategoryChip(
              category.name,
              category.id,
              controller.selectedCategoryId.value == category.id,
            );
          },
        );
      }),
    );
  }

  Widget _buildCategoryChip(String label, String categoryId, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            controller.setSelectedCategory(categoryId);
          } else {
            controller.clearCategoryFilter();
          }
        },
        backgroundColor:
            isSelected ? Theme.of(Get.context!).colorScheme.secondary : null,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : null,
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final Function(Product, int) onAddToCart;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) {
                  print('Error loading image from $url: $error');
                  return const Icon(Icons.error, size: 50);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\Rs ${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                AddToCartButton(
                  onAddToCart: (quantity) => onAddToCart(product, quantity),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildProductCard(Product product) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(Routes.PRODUCT_DETAILS(product.id));
    },
    child: Container(
      width: 160,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: CustomCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'product-${product.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  product.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              product.name,
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(
              '\Rs ${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                  color: Get.theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ),
  );
}

class AddToCartButton extends StatelessWidget {
  final Function(int) onAddToCart;

  const AddToCartButton({Key? key, required this.onAddToCart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showQuantityDialog(context),
      child: const Text('Add to Cart'),
    );
  }

  void _showQuantityDialog(BuildContext context) {
    int quantity = 1;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Quantity'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed:
                        quantity > 1 ? () => setState(() => quantity--) : null,
                  ),
                  Text('$quantity'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => quantity++),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                onAddToCart(quantity);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
