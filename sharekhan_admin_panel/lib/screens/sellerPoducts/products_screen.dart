import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharekhan_admin_panel/tables/seller_product_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:sharekhan_admin_panel/models/product_model.dart';
import 'package:sharekhan_admin_panel/navigation/routes.dart';
import 'package:sharekhan_admin_panel/providers/category_provider.dart';
import 'package:sharekhan_admin_panel/providers/product_provider.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:sharekhan_admin_panel/widgets/common/main_tab_header.dart';
import 'package:sharekhan_admin_panel/widgets/common/spacing.dart';
import 'package:csv/csv.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class SellerProductsScreen extends StatefulWidget {
  const SellerProductsScreen({super.key});

  @override
  State<SellerProductsScreen> createState() => _SellerProductsScreenState();
}

class _SellerProductsScreenState extends State<SellerProductsScreen> {
  void _onToggleActive(ProductModel product, bool isApproved) async {
    final productProvider = context.read<ProductProvider>();
    productProvider.updateProduct(product.copyWith(isApproved: isApproved));
  }

  Future<void> _exportToCSV() async {
    final productProvider = context.read<ProductProvider>();
    List<List<dynamic>> rows = [];
    rows.add([
      "Image",
      "Name",
      "Category",
      "Unit Weight",
      "Unit Price",
      "Remaining Quantity",
      "Is Active",
      "Created At",
      "Updated At"
    ]);
    for (var product in productProvider.products) {
      rows.add([
        product.images.isNotEmpty ? product.images.first : 'No Image',
        product.name,
        product.categoryID,
        product.unitWeight,
        product.unitPrice,
        product.remainingQuantity,
        product.isActive ? "Active" : "Inactive",
        product.createdAt.toIso8601String(),
        product.updatedAt.toIso8601String(),
      ]);
    }

    String csv = const ListToCsvConverter().convert(rows);
    final bytes = utf8.encode(csv);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute("download", "products.csv")
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final categoryProvider = context.watch<CategoryProvider>();
    return Scaffold(
      backgroundColor: AppTheme.colorWhite,
      body: Padding(
        padding: AppTheme.paddingSmall,
        child: Column(
          children: [
            const Spacing(size: AppTheme.spacingLarge),
            MainTabHeader(
              title: 'Products',
              routeName: Routes.productAdd,
              secondButtonText: 'Add Product',
              onExport: _exportToCSV,
            ),
            const Spacing(size: AppTheme.spacingLarge),
            Expanded(
              child: SfDataGrid(
                source: SellerProductDataSource(
                  products: productProvider.products
                      .where((product) => !product.isSheruSpecial)
                      .toList(),
                  categories: categoryProvider.categories,
                  onToggleActive: _onToggleActive,
                ),
                columnWidthMode: ColumnWidthMode.fill,
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                columns: <GridColumn>[
                  GridColumn(
                    columnName: 'images',
                    width: 150,
                    label: Container(
                      padding: AppTheme.paddingTiny,
                      alignment: Alignment.center,
                      child:
                          const Text('Image', style: AppTheme.fontStyleDefault),
                    ),
                  ),
                  GridColumn(
                    columnName: 'name',
                    label: Container(
                      padding: AppTheme.paddingTiny,
                      alignment: Alignment.center,
                      child:
                          const Text('Name', style: AppTheme.fontStyleDefault),
                    ),
                  ),
                  GridColumn(
                    columnName: 'categoryID',
                    label: Container(
                      padding: AppTheme.paddingTiny,
                      alignment: Alignment.center,
                      child: const Text('Category',
                          style: AppTheme.fontStyleDefault),
                    ),
                  ),
                  GridColumn(
                    columnName: 'description',
                    label: Container(
                      padding: AppTheme.paddingTiny,
                      alignment: Alignment.center,
                      child: const Text('Description',
                          style: AppTheme.fontStyleDefault),
                    ),
                  ),
                  GridColumn(
                    columnName: 'unitWeight',
                    label: Container(
                      padding: AppTheme.paddingTiny,
                      alignment: Alignment.center,
                      child: const Text('Unit Weight',
                          style: AppTheme.fontStyleDefault),
                    ),
                  ),
                  GridColumn(
                    columnName: 'unitPrice',
                    label: Container(
                      padding: AppTheme.paddingTiny,
                      alignment: Alignment.center,
                      child: const Text('Unit Price',
                          style: AppTheme.fontStyleDefault),
                    ),
                  ),
                  GridColumn(
                    columnName: 'remainingQuantity',
                    label: Container(
                      padding: AppTheme.paddingTiny,
                      alignment: Alignment.center,
                      child: const Text('Remaining Quantity',
                          style: AppTheme.fontStyleDefault),
                    ),
                  ),
                  GridColumn(
                    columnName: 'isApproved',
                    width: 100,
                    label: Container(
                      padding: AppTheme.paddingTiny,
                      alignment: Alignment.center,
                      child: const Text('Approve',
                          style: AppTheme.fontStyleDefault),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
