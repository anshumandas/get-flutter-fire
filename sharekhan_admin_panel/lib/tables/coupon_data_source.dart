import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:sharekhan_admin_panel/models/coupon_model.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';

class CouponDataSource extends DataGridSource {
  CouponDataSource({
    required List<CouponModel> coupons,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleActive,
  }) {
    _coupons = coupons
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'couponCode', value: e.couponCode),
              DataGridCell<String>(
                  columnName: 'description', value: e.description),
              DataGridCell<int>(columnName: 'maxAmount', value: e.maxAmount),
              DataGridCell<double>(
                  columnName: 'percentage', value: e.percentage),
              DataGridCell<bool>(columnName: 'isActive', value: e.isActive),
              DataGridCell<String>(columnName: 'id', value: e.id),
              DataGridCell<DateTime>(
                  columnName: 'createdAt', value: e.createdAt),
              DataGridCell<DateTime>(
                  columnName: 'updatedAt', value: e.updatedAt),
            ]))
        .toList();
  }

  final Function(CouponModel) onEdit;
  final Function(CouponModel) onDelete;
  final Function(CouponModel, bool) onToggleActive;

  List<DataGridRow> _coupons = [];

  @override
  List<DataGridRow> get rows => _coupons;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final coupon = CouponModel(
      id: row.getCells()[5].value,
      couponCode: row.getCells()[0].value,
      description: row.getCells()[1].value,
      maxAmount: row.getCells()[2].value,
      percentage: row.getCells()[3].value,
      isActive: row.getCells()[4].value,
      userIDs: [],
      createdAt: row.getCells()[6].value,
      updatedAt: row.getCells()[7].value,
    );
    return DataGridRowAdapter(
      cells: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingSmall,
              vertical: AppTheme.spacingTiny),
          child: Text(coupon.couponCode, style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingSmall,
              vertical: AppTheme.spacingTiny),
          child: Text(coupon.description, style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(AppTheme.spacingTiny),
          child: Text(coupon.maxAmount.toString(),
              style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(AppTheme.spacingTiny),
          child: Text(coupon.percentage.toStringAsFixed(2),
              style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(AppTheme.spacingTiny),
          child: Transform.scale(
            scale: 0.8,
            child: Switch(
              activeTrackColor: AppTheme.colorRed,
              value: coupon.isActive,
              onChanged: (value) => onToggleActive(coupon, value),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(AppTheme.spacingTiny),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: AppTheme.colorGrey),
                onPressed: () => onEdit(coupon),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: AppTheme.colorRed),
                onPressed: () => onDelete(coupon),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
