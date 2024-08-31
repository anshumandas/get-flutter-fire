import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/order_controller.dart';
import 'package:get_flutter_fire/app/modules/cart/controllers/product_controller.dart';
import 'package:get_flutter_fire/app/routes/app_routes.dart';
import 'package:get_flutter_fire/app/widgets/common/overlay_loader.dart';
import 'package:get_flutter_fire/app/widgets/common/spacing.dart';
import 'package:get_flutter_fire/app/widgets/orders/primary_button.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  OrdersScreenState createState() => OrdersScreenState();
}

class OrdersScreenState extends State<OrdersScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _orderStatusFilter = [];

  final OrderController orderController = Get.find<OrderController>();
  final ProductController productController = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    orderController.filterOrders(_searchController.text, _orderStatusFilter);
  }

  void _toggleFilter(String status) {
    setState(() {
      if (_orderStatusFilter.contains(status)) {
        _orderStatusFilter.remove(status);
      } else {
        _orderStatusFilter.add(status);
      }
      orderController.filterOrders(_searchController.text, _orderStatusFilter);
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (orderController.isLoading.value) {
        return const LoadingWidget();
      }

      final filteredOrders = orderController.filteredOrders;

      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: AppTheme.paddingSmall,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: AppTheme.cardDecoration,
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Icon(Icons.search,
                                  color: AppTheme.greyTextColor),
                            ),
                            hintText: 'Search for Orders',
                            hintStyle: AppTheme.fontStyleDefault.copyWith(
                              color: AppTheme.greyTextColor,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: AppTheme.spacingTiny),
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                      ),
                    ),
                    const Spacing(
                        isHorizontal: true, size: AppTheme.spacingTiny),
                    _filterByOrderWidget(),
                  ],
                ),
                filteredOrders.isEmpty
                    ? const Column(
                        children: [
                          Spacing(size: AppTheme.spacingSmall),
                          Text(
                            'No Orders Found',
                            style: AppTheme.fontStyleDefault,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                const Spacing(size: AppTheme.spacingSmall),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    final products = order.products
                        .map((product) =>
                            productController.getProductByID(product.id))
                        .toList();
                    final productNames = products.map((p) {
                      return p.name;
                    }).toList();

                    return Padding(
                      padding:
                          const EdgeInsets.only(bottom: AppTheme.spacingSmall),
                      child: Container(
                        decoration: AppTheme.cardDecoration,
                        child: Padding(
                          padding: AppTheme.paddingSmall,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Order ID: ",
                                      style: AppTheme.fontStyleDefault,
                                    ),
                                    TextSpan(
                                      text: "#${order.id}",
                                      style: AppTheme.fontStyleDefaultBold
                                          .copyWith(
                                        color: AppTheme.colorDarkBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacing(size: AppTheme.spacingTiny),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Status: ",
                                      style: AppTheme.fontStyleDefault,
                                    ),
                                    TextSpan(
                                      text: order.currentStatus.name,
                                      style: AppTheme.fontStyleDefaultBold
                                          .copyWith(
                                        color: AppTheme.colorDarkBlue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacing(size: AppTheme.spacingTiny),
                              if (productNames.length == 1)
                                Text(
                                  productNames[0],
                                  style: AppTheme.fontStyleDefault,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              else if (productNames.length == 2)
                                Text(
                                  productNames.join(', '),
                                  style: AppTheme.fontStyleDefault,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              else if (productNames.length > 2)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productNames.take(2).join(', '),
                                      style: AppTheme.fontStyleDefault,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${productNames.length - 2} more products',
                                      style: AppTheme.fontStyleDefault.copyWith(
                                          color: AppTheme.greyTextColor),
                                    ),
                                  ],
                                ),
                              const Spacing(size: AppTheme.spacingTiny),
                              Text(
                                'Total Products: ${order.products.length}',
                                style: AppTheme.fontStyleDefault,
                              ),
                              const Spacing(size: AppTheme.spacingSmall),
                              PrimaryButton(
                                onPressed: () => Get.toNamed(
                                    Routes.ORDER_DETAILS,
                                    arguments: {'id': order.id}),
                                label: 'View Details',
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _filterByOrderWidget() {
    return InkWell(
      onTap: () {
        Get.dialog(
          Dialog(
            child: Container(
              padding: AppTheme.paddingSmall,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: _buildFilterDialog(),
            ),
          ),
        );
      },
      child: Container(
        height: 50,
        padding: AppTheme.paddingTiny,
        decoration: AppTheme.cardDecoration,
        child: const Row(
          children: [
            Text("Filter By", style: AppTheme.fontStyleDefault),
            Spacing(size: AppTheme.spacingTiny, isHorizontal: true),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDialog() {
    final statusItems = ['Pending', 'Delivered', 'Cancelled', 'placed'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: statusItems.map((status) {
        return CheckboxListTile(
          title: Text(status.capitalizeFirst!),
          value: _orderStatusFilter.contains(status),
          onChanged: (bool? value) {
            _toggleFilter(status);
            Get.back();
          },
          controlAffinity: ListTileControlAffinity.leading,
        );
      }).toList(),
    );
  }
}
