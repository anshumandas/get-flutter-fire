import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:sharekhan_admin_panel/models/category_model.dart';
import 'package:sharekhan_admin_panel/models/product_model.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';

class SellerProductDataSource extends DataGridSource {
  SellerProductDataSource({
    required List<ProductModel> products,
    required List<CategoryModel> categories,
    required this.onToggleActive,
  }) {
    _products = products
        .map<DataGridRow>((product) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'name', value: product.name),
              DataGridCell<String>(
                  columnName: 'categoryID', value: product.categoryID),
              DataGridCell<String>(
                  columnName: 'images', value: product.images.join(", ")),
              DataGridCell<String>(
                  columnName: 'description', value: product.description),
              DataGridCell<double>(
                  columnName: 'unitWeight', value: product.unitWeight),
              DataGridCell<int>(
                  columnName: 'unitPrice', value: product.unitPrice),
              DataGridCell<int>(
                  columnName: 'remainingQuantity',
                  value: product.remainingQuantity),
              DataGridCell<bool>(
                  columnName: 'isActive', value: product.isActive),
              DataGridCell<String>(columnName: 'id', value: product.id),
              DataGridCell<DateTime>(
                  columnName: 'createdAt', value: product.createdAt),
              DataGridCell<DateTime>(
                  columnName: 'updatedAt', value: product.updatedAt),
              DataGridCell<String>(
                columnName: 'sellerId',
                value: product.sellerId,
              ),
              DataGridCell<bool>(
                columnName: 'isSheruSpecial',
                value: product.isSheruSpecial,
              ),
              DataGridCell<bool>(
                columnName: 'isApproved',
                value: product.isApproved,
              ),
            ]))
        .toList();

    _categories = categories;
  }

  final Function(ProductModel, bool) onToggleActive;

  List<DataGridRow> _products = [];
  List<CategoryModel> _categories = [];

  @override
  List<DataGridRow> get rows => _products;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final product = ProductModel(
      id: row.getCells()[8].value,
      categoryID: row.getCells()[1].value,
      images: (row.getCells()[2].value as String).split(", "),
      name: row.getCells()[0].value,
      description: row.getCells()[3].value,
      unitWeight: row.getCells()[4].value,
      unitPrice: row.getCells()[5].value,
      remainingQuantity: row.getCells()[6].value,
      isActive: row.getCells()[7].value,
      createdAt: row.getCells()[9].value,
      updatedAt: row.getCells()[10].value,
      sellerId: row.getCells()[11].value,
      isSheruSpecial: row.getCells()[12].value,
      isApproved: row.getCells()[13].value,
    );

    return DataGridRowAdapter(
      cells: [
        Container(
          padding: AppTheme.paddingTiny,
          child: Image.network(product.images[0],
              width: 100, height: 100, fit: BoxFit.cover),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingSmall,
              vertical: AppTheme.spacingTiny),
          child: Text(product.name, style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingSmall,
              vertical: AppTheme.spacingTiny),
          child: Text(
              _categories
                  .firstWhere((element) => element.id == product.categoryID)
                  .name,
              style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingSmall,
              vertical: AppTheme.spacingTiny),
          child:
              Text(product.description, style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.center,
          padding: AppTheme.paddingTiny,
          child: Text(product.unitWeight.toStringAsFixed(2),
              style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.center,
          padding: AppTheme.paddingTiny,
          child: Text(product.unitPrice.toString(),
              style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.center,
          padding: AppTheme.paddingTiny,
          child: Text(product.remainingQuantity.toString(),
              style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.center,
          padding: AppTheme.paddingTiny,
          child: Transform.scale(
            scale: 0.8,
            child: Switch(
              activeTrackColor: AppTheme.colorRed,
              value: product.isApproved,
              onChanged: (value) => onToggleActive(product, value),
            ),
          ),
        ),
      ],
    );
  }
}
