import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/products_admin/controllers/products_admin_controller.dart';
import 'package:get_flutter_fire/app/widgets/drop_down_button.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsAdminController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Add New Product',
            style: TextStyle(
                fontSize: 30,
                color: Colors.orange,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: ctrl.productNameCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      label: const Text("Product Name"),
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 160, 160, 160)),
                      hintText: "Enter Your Product Name"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: ctrl.productDescriptionCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      label: const Text("Product Description"),
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 160, 160, 160)),
                      hintText: "Enter Your Product Description"),
                  maxLines: 4,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: ctrl.productImgCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      label: const Text("Image URL"),
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 160, 160, 160)),
                      hintText: "Enter Your Product's Image"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: ctrl.productPriceCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      label: const Text("Product Price"),
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 160, 160, 160)),
                      hintText: "Enter Your Product's Price"),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                        child: DropDownBtn(
                      items: const [
                        'Clothing',
                        'Shoes',
                        'Electronics',
                        'Sports'
                      ],
                      selectedItemsText: ctrl.category,
                      onSelected: (selectedValue) {
                        ctrl.category = selectedValue ?? 'Category';
                        ctrl.update();
                      },
                    )),
                    Flexible(
                        child: DropDownBtn(
                            items: const [
                          'Nike',
                          'Zara',
                          'H&M',
                          'Samsung',
                          'Bata'
                        ],
                            selectedItemsText: ctrl.brand,
                            onSelected: (selectedValue) {
                              ctrl.brand = selectedValue ?? 'Brand';
                              ctrl.update();
                            })),
                  ],
                ),
                Text("Offer Products"),
                DropDownBtn(
                    items: ['true', 'false'],
                    selectedItemsText: ctrl.offer == true ? 'yes' : 'no',
                    onSelected: (selectedValue) {
                      ctrl.offer =
                          bool.tryParse(selectedValue ?? 'false') ?? false;
                      ctrl.update();
                    }),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      ctrl.addProduct();
                    },
                    child: const Text("Add Product"))
              ],
            ),
          ),
        ),
      );
    });
  }
}
