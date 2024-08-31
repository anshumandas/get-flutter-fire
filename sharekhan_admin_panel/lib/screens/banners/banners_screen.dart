import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:sharekhan_admin_panel/models/banner_model.dart';
import 'package:sharekhan_admin_panel/navigation/go_router.dart';
import 'package:sharekhan_admin_panel/navigation/routes.dart';
import 'package:sharekhan_admin_panel/providers/banner_provider.dart';
import 'package:sharekhan_admin_panel/providers/product_provider.dart';
import 'package:sharekhan_admin_panel/tables/banner_data_source.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:sharekhan_admin_panel/widgets/common/custom_button.dart';
import 'package:sharekhan_admin_panel/widgets/common/main_tab_header.dart';
import 'package:sharekhan_admin_panel/widgets/common/spacing.dart';
import 'package:csv/csv.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class BannersScreen extends StatefulWidget {
  const BannersScreen({super.key});

  @override
  State<BannersScreen> createState() => _BannersScreenState();
}

class _BannersScreenState extends State<BannersScreen> {
  void _onEdit(BannerModel banner) {
    context.go(Routes.bannerEdit, extra: banner);
  }

  void _onDelete(BannerModel banner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Banner', style: AppTheme.fontStyleMedium),
          content: const Text(
            'Are you sure you want to delete this banner?',
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
                    final bannerProvider = context.read<BannerProvider>();
                    bannerProvider.deleteBanner(banner);
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

  void _onToggleActive(BannerModel banner, bool isActive) async {
    final bannerProvider = context.read<BannerProvider>();
    await bannerProvider.toggleActive(banner, isActive);
  }

  Future<void> _exportToCSV() async {
    final bannerProvider = context.read<BannerProvider>();
    List<List<dynamic>> rows = [];
    rows.add([
      "Image URL",
      "Product ID",
      "Description",
      "Is Active",
      "Created At",
      "Updated At"
    ]);
    for (var banner in bannerProvider.banners) {
      rows.add([
        banner.imageUrl,
        banner.productID,
        banner.description,
        banner.isActive,
        banner.createdAt,
        banner.updatedAt,
      ]);
    }

    String csv = const ListToCsvConverter().convert(rows);
    final bytes = utf8.encode(csv);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute("download", "banners.csv")
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final bannerProvider = context.watch<BannerProvider>();
    final productProvider = context.watch<ProductProvider>();
    return Scaffold(
      backgroundColor: AppTheme.colorWhite,
      body: Padding(
        padding: AppTheme.paddingSmall,
        child: Column(
          children: [
            const Spacing(size: AppTheme.spacingLarge),
            MainTabHeader(
              title: 'Banners',
              routeName: Routes.bannerAdd,
              secondButtonText: 'Add Banner',
              onExport: _exportToCSV,
            ),
            const Spacing(size: AppTheme.spacingLarge),
            Expanded(
              child: SfDataGrid(
                source: BannerDataSource(
                  banners: bannerProvider.banners,
                  products: productProvider.products,
                  onEdit: _onEdit,
                  onDelete: _onDelete,
                  onToggleActive: _onToggleActive,
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
                    columnName: 'productID',
                    label: Container(
                      padding: AppTheme.paddingTiny,
                      alignment: Alignment.center,
                      child: const Text('Product Name',
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
                    columnName: 'isActive',
                    width: 100,
                    label: Container(
                      padding: AppTheme.paddingTiny,
                      alignment: Alignment.center,
                      child:
                          const Text('Show', style: AppTheme.fontStyleDefault),
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
