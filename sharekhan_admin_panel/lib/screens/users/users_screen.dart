import 'dart:convert';
import 'package:sharekhan_admin_panel/providers/user_provider.dart';
import 'package:sharekhan_admin_panel/tables/user_data_source.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:sharekhan_admin_panel/widgets/common/main_tab_header.dart';
import 'package:sharekhan_admin_panel/widgets/common/spacing.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  Future<void> _exportToCSV() async {
    final userProvider = context.read<UserProvider>();
    List<List<dynamic>> rows = [];
    rows.add([
      "Name",
      "Phone Number",
      "Email",
      "Business Name",
      "Business Type",
      "GST Number",
      "PAN Number",
      "User Type",
      "Last Seen At"
    ]);
    for (var user in userProvider.users) {
      rows.add([
        user.name,
        user.phoneNumber,
        user.email ?? '',
        user.businessName ?? '',
        user.businessType ?? '',
        user.gstNumber ?? '',
        user.panNumber ?? '',
        user.userType.name,
        user.lastSeenAt.toIso8601String(),
      ]);
    }

    String csv = const ListToCsvConverter().convert(rows);
    final bytes = utf8.encode(csv);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute("download", "users.csv")
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    return Scaffold(
      backgroundColor: AppTheme.colorWhite,
      body: Padding(
        padding: AppTheme.paddingSmall,
        child: Column(
          children: [
            const Spacing(size: AppTheme.spacingLarge),
            MainTabHeader(
              title: 'Users',
              routeName: '',
              secondButtonText: '',
              onExport: _exportToCSV,
              showSecondButton: false,
            ),
            const Spacing(size: AppTheme.spacingLarge),
            Expanded(
              child: SfDataGrid(
                source: UserDataSource(
                  users: userProvider.users,
                ),
                columnWidthMode: ColumnWidthMode.fill,
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.both,
                columns: <GridColumn>[
                  GridColumn(
                      columnName: 'name',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text('Name'))),
                  GridColumn(
                      columnName: 'phoneNumber',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text('Phone Number'))),
                  GridColumn(
                      columnName: 'email',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text('Email'))),
                  GridColumn(
                      columnName: 'businessName',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text('Business Name'))),
                  GridColumn(
                      columnName: 'businessType',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text('Business Type'))),
                  GridColumn(
                      columnName: 'gstNumber',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text('GST Number'))),
                  GridColumn(
                      columnName: 'panNumber',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text('PAN Number'))),
                  GridColumn(
                      columnName: 'userType',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text('User Type'))),
                  GridColumn(
                      columnName: 'lastSeenAt',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: const Text('Last Seen'))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
