import 'package:flutter/material.dart';
import 'package:sharekhan_admin_panel/enums/enum_parser.dart';
import 'package:sharekhan_admin_panel/models/user_model.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserDataSource extends DataGridSource {
  UserDataSource({
    required List<UserModel> users,
  }) {
    _users = users
        .map<DataGridRow>((user) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'name', value: user.name),
              DataGridCell<String>(
                  columnName: 'phoneNumber', value: user.phoneNumber),
              DataGridCell<String?>(columnName: 'email', value: user.email),
              DataGridCell<String?>(
                  columnName: 'businessName', value: user.businessName),
              DataGridCell<String?>(
                  columnName: 'businessType', value: user.businessType),
              DataGridCell<String?>(
                  columnName: 'gstNumber', value: user.gstNumber),
              DataGridCell<String?>(
                  columnName: 'panNumber', value: user.panNumber),
              DataGridCell<String>(
                  columnName: 'userType', value: user.userType.name),
              DataGridCell<DateTime>(
                  columnName: 'lastSeenAt', value: user.lastSeenAt),
            ]))
        .toList();
  }

  List<DataGridRow> _users = [];

  @override
  List<DataGridRow> get rows => _users;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final user = UserModel(
      id: '',
      name: row.getCells()[0].value,
      phoneNumber: row.getCells()[1].value,
      email: row.getCells()[2].value,
      isBusiness: row.getCells()[3].value != null,
      businessName: row.getCells()[3].value,
      businessType: row.getCells()[4].value,
      gstNumber: row.getCells()[5].value,
      panNumber: row.getCells()[6].value,
      userType: parseUserType(row.getCells()[7].value),
      defaultAddressID: '',
      createdAt: DateTime.now(),
      lastSeenAt: row.getCells()[8].value,
    );

    return DataGridRowAdapter(
      cells: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingSmall,
              vertical: AppTheme.spacingTiny),
          child: Text(user.name, style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingSmall,
              vertical: AppTheme.spacingTiny),
          child: Text(user.phoneNumber, style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingSmall,
              vertical: AppTheme.spacingTiny),
          child: Text(user.email ?? '-', style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingSmall,
              vertical: AppTheme.spacingTiny),
          child: Text(user.businessName ?? '-',
              style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingSmall,
              vertical: AppTheme.spacingTiny),
          child: Text(user.businessType ?? '-',
              style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingSmall,
              vertical: AppTheme.spacingTiny),
          child:
              Text(user.gstNumber ?? '-', style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingSmall,
              vertical: AppTheme.spacingTiny),
          child:
              Text(user.panNumber ?? '-', style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingSmall,
              vertical: AppTheme.spacingTiny),
          child: Text(user.userType.name, style: const TextStyle(fontSize: 16)),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(AppTheme.spacingTiny),
          child: Text(user.lastSeenAt.toString(),
              style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
