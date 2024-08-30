import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/products_admin/views/add_product_view.dart';
import '../controllers/products_admin_controller.dart';

class ProductsAdminView extends GetView<ProductsAdminController> {
  const ProductsAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Title'),
              subtitle: Text('Price: 199'),
              trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Get.to(AddProductView());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
