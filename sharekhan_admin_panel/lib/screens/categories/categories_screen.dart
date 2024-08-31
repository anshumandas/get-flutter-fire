import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:sharekhan_admin_panel/models/category_model.dart';
import 'package:sharekhan_admin_panel/navigation/go_router.dart';
import 'package:sharekhan_admin_panel/navigation/routes.dart';
import 'package:sharekhan_admin_panel/providers/category_provider.dart';
import 'package:sharekhan_admin_panel/tables/category_data_source.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:sharekhan_admin_panel/widgets/common/custom_button.dart';
import 'package:sharekhan_admin_panel/widgets/common/main_tab_header.dart';
import 'package:sharekhan_admin_panel/widgets/common/spacing.dart';
import 'package:csv/csv.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  void _onEdit(CategoryModel category) {
    context.go(Routes.categoryEdit, extra: category);
  }

  void _onDelete(CategoryModel category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Category', style: AppTheme.fontStyleMedium),
          content: const Text(
            'Are you sure you want to delete this category?',
            style: AppTheme.fontStyleDefault,
          ),
          shape: AppTheme.rrShape,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: () => router.pop(),
                  text: 'No, Cancel',
                  fillColor: AppTheme.colorBlack,
                  textColor: AppTheme.colorWhite,
                ),
                const Spacing(size: AppTheme.spacingSmall, isHorizontal: true),
                CustomButton(
                  onTap: () async {
                    final categoryProvider = context.read<CategoryProvider>();
                    categoryProvider.deleteCategory(category);
                    router.pop();
                  },
                  text: 'Yes, Delete',
                  fillColor: AppTheme.colorRed,
                  textColor: AppTheme.colorWhite,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _exportToCSV() async {
    final categoryProvider = context.read<CategoryProvider>();
    List<List<dynamic>> rows = [];
    rows.add(["Image URL", "Name", "Description", "Created At", "Updated At"]);
    for (var category in categoryProvider.categories) {
      rows.add([
        category.imageUrl,
        category.name,
        category.description,
        category.createdAt,
        category.updatedAt,
      ]);
    }

    String csv = const ListToCsvConverter().convert(rows);
    final bytes = utf8.encode(csv);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute("download", "categories.csv")
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryProvider>();
    return Scaffold(
      backgroundColor: AppTheme.colorWhite,
      body: Padding(
        padding: AppTheme.paddingSmall,
        child: Column(
          children: [
            const Spacing(size: AppTheme.spacingLarge),
            MainTabHeader(
              title: 'Categories',
              routeName: Routes.categoryAdd,
              secondButtonText: 'Add Category',
              onExport: _exportToCSV,
            ),
            const Spacing(size: AppTheme.spacingLarge),
            Expanded(
              child: SfDataGrid(
                source: CategoryDataSource(
                  categories: categoryProvider.categories,
                  onEdit: _onEdit,
                  onDelete: _onDelete,
                ),
                columnWidthMode: ColumnWidthMode.fill,
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                columns: <GridColumn>[
                  GridColumn(
                    columnName: 'imageUrl',
                    width: 100,
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
                    columnName: 'description',
                    label: Container(
                      padding: AppTheme.paddingTiny,
                      alignment: Alignment.center,
                      child: const Text('Description',
                          style: AppTheme.fontStyleDefault),
                    ),
                  ),
                  GridColumn(
                    columnName: 'actions',
                    width: 100,
                    label: Container(
                      padding: AppTheme.paddingTiny,
                      alignment: Alignment.center,
                      child: const Text('Actions',
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
