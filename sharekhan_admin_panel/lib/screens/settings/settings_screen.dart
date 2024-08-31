import 'package:sharekhan_admin_panel/navigation/routes.dart';
import 'package:sharekhan_admin_panel/providers/setting_provider.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:sharekhan_admin_panel/widgets/common/main_tab_header.dart';
import 'package:sharekhan_admin_panel/widgets/common/spacing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  bool _isMaintenanceMode = false;

  init() async {
    final settingProvider = context.read<SettingProvider>();
    setState(() {
      _isMaintenanceMode = settingProvider.settings.version.isMaintenance;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void _toggleMaintenanceMode(bool value) {
    setState(() {
      _isMaintenanceMode = value;
    });
    final settingProvider = context.read<SettingProvider>();
    settingProvider.updateMaintainance(value);
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingProvider>();
    return Scaffold(
      backgroundColor: AppTheme.colorWhite,
      body: Padding(
        padding: AppTheme.paddingSmall,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacing(size: AppTheme.spacingLarge),
            MainTabHeader(
              title: 'Settings',
              routeName: Routes.settingsEdit,
              secondButtonText: 'Update Settings',
              showExportButton: false,
              onExport: () {},
            ),
            const Spacing(size: AppTheme.spacingLarge),
            const Divider(color: AppTheme.borderColor, thickness: 1),
            const Spacing(size: AppTheme.spacingSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Android Version',
                      style: AppTheme.fontStyleDefaultBold,
                    ),
                    const Spacing(size: AppTheme.spacingTiny),
                    Text(
                      settingsProvider
                          .settings.version.androidVersion.versionName,
                      style: AppTheme.fontStyleDefault,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mandatory to push update on Android',
                      style: AppTheme.fontStyleDefaultBold,
                    ),
                    const Spacing(size: AppTheme.spacingTiny),
                    Text(
                      settingsProvider.settings.version.androidVersion.mandatory
                          ? 'Yes'
                          : 'No',
                      style: AppTheme.fontStyleDefault,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'IOS Version',
                      style: AppTheme.fontStyleDefaultBold,
                    ),
                    const Spacing(size: AppTheme.spacingTiny),
                    Text(
                      settingsProvider.settings.version.iosVersion.versionName,
                      style: AppTheme.fontStyleDefault,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mandatory to push update on IOS',
                      style: AppTheme.fontStyleDefaultBold,
                    ),
                    const Spacing(size: AppTheme.spacingTiny),
                    Text(
                      settingsProvider.settings.version.iosVersion.mandatory
                          ? 'Yes'
                          : 'No',
                      style: AppTheme.fontStyleDefault,
                    ),
                  ],
                ),
              ],
            ),
            const Spacing(size: AppTheme.spacingMedium),
            const Divider(color: AppTheme.borderColor, thickness: 1),
            const Spacing(size: AppTheme.spacingSmall),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Maintenance Mode',
                      style: AppTheme.fontStyleDefaultBold,
                    ),
                    const Spacing(
                        size: AppTheme.spacingTiny, isHorizontal: true),
                    Switch(
                      value: _isMaintenanceMode,
                      onChanged: _toggleMaintenanceMode,
                      activeColor: AppTheme.colorRed,
                    ),
                  ],
                ),
                const Spacing(size: AppTheme.spacingSmall),
                Text(
                  _isMaintenanceMode
                      ? 'App is in maintenance mode'
                      : 'App is not in maintenance mode',
                  style: AppTheme.fontStyleDefault,
                ),
              ],
            ),
            const Spacing(size: AppTheme.spacingMedium),
            const Divider(color: AppTheme.borderColor, thickness: 1),
            const Spacing(size: AppTheme.spacingSmall),
          ],
        ),
      ),
    );
  }
}
