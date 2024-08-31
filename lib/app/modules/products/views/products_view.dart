import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/role.dart';
import '../../../routes/app_pages.dart';
import '../controllers/products_controller.dart';
import '../../product_details/controllers/product_details_controller.dart'; // Import ProductDetailsController
import '../../cart/controllers/cart_controller.dart'; // Import CartController

class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    var arg = Get.rootDelegate.arguments();
    var userRole = arg != null ? Get.rootDelegate.arguments()["role"] : Role.guest;

    return Scaffold(
      floatingActionButton: (userRole == Role.admin)
          ? FloatingActionButton.extended(
        onPressed: controller.loadDemoProductsFromSomeWhere,
        label: const Text('Add'),
      )
          : null,
      body: Column(
        children: [
          // Search bar widget
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'Where to?',
                contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
              onChanged: (value) {
                controller.searchQuery.value = value;
              },
            ),
          ),

          // Row for persons and date selection
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  // Dropdown for number of persons
                  Expanded(
                    flex: 1,
                    child: DropdownButton<int>(
                      value: controller.selectedPersons.value,
                      onChanged: (value) {
                        controller.selectedPersons.value = value!;
                      },
                      items: List.generate(10, (index) {
                        return DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text('${index + 1} Persons'),
                        );
                      }),
                      isExpanded: true,
                      hint: Icon(
                        Icons.people,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0), // Spacing between dropdowns

                  // Check-in Date picker
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: controller.selectedCheckInDate.value ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          controller.selectedCheckInDate.value = pickedDate;
                        }
                      },
                      child: Obx(() => TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: controller.selectedCheckInDate.value == null
                              ? 'Check-in'
                              : '${controller.selectedCheckInDate.value?.toLocal().toString().split(' ')[0]}',
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                        ),
                        enabled: false,
                        style: TextStyle(fontSize: 16),
                      )),
                    ),
                  ),
                  SizedBox(width: 12.0),

                  // Check-out Date picker
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: controller.selectedCheckInDate.value ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          controller.selectedCheckOutDate.value = pickedDate;
                        }
                      },
                      child: Obx(() => TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: controller.selectedCheckOutDate.value == null
                              ? 'Check-out'
                              : '${controller.selectedCheckOutDate.value?.toLocal().toString().split(' ')[0]}',
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                        ),
                        enabled: false,
                        style: TextStyle(fontSize: 16),
                      )),
                    ),
                  ),
                ],
              )),
          SizedBox(height: 12.0),
          Expanded(
            child: Obx(
                  () => RefreshIndicator(
                onRefresh: () async {
                  controller.products.clear();
                  controller.loadDemoProductsFromSomeWhere();
                },
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  itemCount: controller.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final item = controller.filteredProducts[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        onTap: () {
                          // Register the controllers before navigating
                          Get.lazyPut(() => ProductDetailsController(item.id));
                          Get.lazyPut(() => CartController());

                          // Navigate to the ProductDetailsView
                          Get.toNamed(Routes.PRODUCT_DETAILS(item.id));
                        },
                        contentPadding: EdgeInsets.all(16.0),
                        leading: Image.asset(
                          item.imageAsset,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          item.name,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.0),
                            Text('Location: ${item.location}', style: TextStyle(fontSize: 16)),
                            Text('Price: Rs ${item.price} night', style: TextStyle(fontSize: 16))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
