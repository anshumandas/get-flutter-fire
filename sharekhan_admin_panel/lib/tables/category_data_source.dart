import 'package:sharekhan_admin_panel/models/category_model.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CategoryDataSource extends DataGridSource {
  CategoryDataSource({
    required List<CategoryModel> categories,
    required this.onEdit,
    required this.onDelete,
  }) {
    _categories = categories
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'imageUrl', value: e.imageUrl),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'description', value: e.description),
              DataGridCell<String>(columnName: 'id', value: e.id),
              DataGridCell<DateTime>(
                  columnName: 'createdAt', value: e.createdAt),
              DataGridCell<DateTime>(
                  columnName: 'updatedAt', value: e.updatedAt),
            ]))
        .toList();
  }

  final Function(CategoryModel) onEdit;
  final Function(CategoryModel) onDelete;

  List<DataGridRow> _categories = [];

  @override
  List<DataGridRow> get rows => _categories;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final category = CategoryModel(
      imageUrl: row.getCells()[0].value,
      name: row.getCells()[1].value,
      description: row.getCells()[2].value,
      id: row.getCells()[3].value,
      createdAt: row.getCells()[4].value,
      updatedAt: row.getCells()[5].value,
    );
    return DataGridRowAdapter(
      cells: [
        Container(
          padding: AppTheme.paddingTiny,
          child: Image.network(category.imageUrl,
              width: 100, height: 100, fit: BoxFit.cover),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(category.name, style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child:
              Text(category.description, style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.center,
          padding: AppTheme.paddingTiny,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: AppTheme.colorGrey),
                onPressed: () => onEdit(category),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: AppTheme.colorRed),
                onPressed: () => onDelete(category),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
