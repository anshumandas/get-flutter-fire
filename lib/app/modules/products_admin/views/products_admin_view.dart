import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/products_admin/views/add_product_view.dart';
import '../controllers/products_admin_controller.dart';

class ProductsAdminView extends GetView<ProductsAdminController> {
  const ProductsAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsAdminController>(builder: (ctrl) {
      return Scaffold(
        body: ListView.builder(
            itemCount: ctrl.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(ctrl.products[index].name ?? ''),
                subtitle: Text((ctrl.products[index].price ?? '').toString()),
                trailing: IconButton(
                    onPressed: () {
                      ctrl.deleteProduct(ctrl.products[index].id ?? '');
                    },
                    icon: Icon(Icons.delete)),
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
    });
  }
}
