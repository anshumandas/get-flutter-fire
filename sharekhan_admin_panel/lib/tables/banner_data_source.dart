import 'package:sharekhan_admin_panel/models/banner_model.dart';
import 'package:sharekhan_admin_panel/models/product_model.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class BannerDataSource extends DataGridSource {
  BannerDataSource({
    required List<BannerModel> banners,
    required List<ProductModel> products,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleActive,
  }) {
    _banners = banners
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'imageUrl', value: e.imageUrl),
              DataGridCell<String>(columnName: 'productID', value: e.productID),
              DataGridCell<String>(
                  columnName: 'description', value: e.description),
              DataGridCell<bool>(columnName: 'isActive', value: e.isActive),
              DataGridCell<String>(columnName: 'id', value: e.id),
              DataGridCell<DateTime>(
                  columnName: 'createdAt', value: e.createdAt),
              DataGridCell<DateTime>(
                  columnName: 'updatedAt', value: e.updatedAt),
            ]))
        .toList();
    _products = products;
  }

  final Function(BannerModel) onEdit;
  final Function(BannerModel) onDelete;
  final Function(BannerModel, bool) onToggleActive;

  List<DataGridRow> _banners = [];
  List<ProductModel> _products = [];

  @override
  List<DataGridRow> get rows => _banners;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final banner = BannerModel(
      imageUrl: row.getCells()[0].value,
      productID: row.getCells()[1].value,
      description: row.getCells()[2].value,
      isActive: row.getCells()[3].value,
      id: row.getCells()[4].value,
      createdAt: row.getCells()[5].value,
      updatedAt: row.getCells()[6].value,
    );

    return DataGridRowAdapter(
      cells: [
        Container(
          padding: AppTheme.paddingTiny,
          child: Image.network(banner.imageUrl,
              width: 100, height: 100, fit: BoxFit.cover),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
              _products
                  .firstWhere((element) => element.id == banner.productID)
                  .name,
              style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(banner.description, style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.center,
          padding: AppTheme.paddingTiny,
          child: Transform.scale(
            scale: 0.8,
            child: Switch(
              activeTrackColor: AppTheme.colorRed,
              value: banner.isActive,
              onChanged: (value) => onToggleActive(banner, value),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: AppTheme.paddingTiny,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: AppTheme.colorGrey),
                onPressed: () => onEdit(banner),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: AppTheme.colorRed),
                onPressed: () => onDelete(banner),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
