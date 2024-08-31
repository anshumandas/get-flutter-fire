import 'dart:convert';
import 'package:sharekhan_admin_panel/providers/coupon_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:sharekhan_admin_panel/models/coupon_model.dart';
import 'package:sharekhan_admin_panel/navigation/go_router.dart';
import 'package:sharekhan_admin_panel/navigation/routes.dart';
import 'package:sharekhan_admin_panel/tables/coupon_data_source.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:sharekhan_admin_panel/widgets/common/custom_button.dart';
import 'package:sharekhan_admin_panel/widgets/common/main_tab_header.dart';
import 'package:sharekhan_admin_panel/widgets/common/spacing.dart';
import 'package:csv/csv.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  void _onEdit(CouponModel coupon) {
    context.go(Routes.couponEdit, extra: coupon);
  }

  void _onDelete(CouponModel coupon) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Coupon', style: AppTheme.fontStyleMedium),
          content: const Text(
            'Are you sure you want to delete this coupon?',
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
                    final couponProvider = context.read<CouponProvider>();
                    couponProvider.deleteCoupon(coupon);
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

  void _onToggleActive(CouponModel coupon, bool isActive) async {
    final couponProvider = context.read<CouponProvider>();
    await couponProvider.toggleActive(coupon, isActive);
  }

  Future<void> _exportToCSV() async {
    final couponProvider = context.read<CouponProvider>();
    List<List<dynamic>> rows = [];
    rows.add([
      "Coupon Code",
      "Description",
      "Max Amount",
      "Percentage",
      "Is Active",
      "Created At",
      "Updated At"
    ]);
    for (var coupon in couponProvider.coupons) {
      rows.add([
        coupon.couponCode,
        coupon.description,
        coupon.maxAmount,
        coupon.percentage,
        coupon.isActive,
        coupon.createdAt,
        coupon.updatedAt,
      ]);
    }

    String csv = const ListToCsvConverter().convert(rows);
    final bytes = utf8.encode(csv);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute("download", "coupons.csv")
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final couponProvider = context.watch<CouponProvider>();
    return Scaffold(
      backgroundColor: AppTheme.colorWhite,
      body: Padding(
        padding: AppTheme.paddingSmall,
        child: Column(
          children: [
            const Spacing(size: AppTheme.spacingLarge),
            MainTabHeader(
              title: 'Coupons',
              routeName: Routes.couponAdd,
              secondButtonText: 'Add Coupon',
              onExport: _exportToCSV,
            ),
            const Spacing(size: AppTheme.spacingLarge),
            Expanded(
              child: SfDataGrid(
                source: CouponDataSource(
                  coupons: couponProvider.coupons,
                  onEdit: _onEdit,
                  onDelete: _onDelete,
                  onToggleActive: _onToggleActive,
                ),
                columnWidthMode: ColumnWidthMode.fill,
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                columns: <GridColumn>[
                  GridColumn(
                    columnName: 'couponCode',
                    label: Container(
                      padding: AppTheme.paddingTiny,
                      alignment: Alignment.center,
                      child: const Text('Coupon Code',
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
                    width: 200,
                    columnName: 'maxAmount',
                    label: Container(
                      padding: AppTheme.paddingTiny,
                      alignment: Alignment.center,
                      child: const Text('Max Amount',
                          style: AppTheme.fontStyleDefault),
                    ),
                  ),
                  GridColumn(
                    width: 100,
                    columnName: 'percentage',
                    label: Container(
                      padding: AppTheme.paddingTiny,
                      alignment: Alignment.center,
                      child: const Text('Percentage',
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
