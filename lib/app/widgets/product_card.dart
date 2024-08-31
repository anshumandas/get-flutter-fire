import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.offerTag,
      required this.price,
      required this.productTap});
  final String name;
  final String imageUrl;
  final double price;
  final String offerTag;
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
                  height: 120,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Rs. $price',
                style: TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  offerTag,
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
