import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.offerTag,
    required this.price,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    required this.productTap,
  });

  final String name;
  final String imageUrl;
  final double price;
  final String offerTag;
  final int quantity;
  final Function onIncrease;
  final Function onDecrease;
  final Function productTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        productTap();
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  height: 170,
                  // alignment: Alignment.topCenter,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                name,
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                'Rs. $price',
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  offerTag,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => onDecrease(),
                    icon: const Icon(Icons.remove),
                  ),
                  Text(quantity.toString()),
                  IconButton(
                    onPressed: () => onIncrease(),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
