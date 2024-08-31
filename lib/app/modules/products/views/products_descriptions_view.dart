import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/models/products_admin.dart';

class ProductsDescriptionsView extends StatelessWidget {
  final Product product;
  const ProductsDescriptionsView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.image ?? '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300,
                )),
            const SizedBox(
              height: 20,
            ),
            Text(product.name ?? '',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            Text(
              product.description ?? '',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Rs. ${product.price}',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelText: 'Enter Your Billing Address'),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.orange,
                ),
                child: const Text(
                  'Buy Now',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
