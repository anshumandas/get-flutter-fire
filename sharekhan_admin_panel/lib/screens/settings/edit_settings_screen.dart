import 'package:sharekhan_admin_panel/models/settings_model.dart';
import 'package:sharekhan_admin_panel/navigation/go_router.dart';
import 'package:sharekhan_admin_panel/navigation/routes.dart';
import 'package:sharekhan_admin_panel/providers/setting_provider.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:sharekhan_admin_panel/widgets/common/custom_loading.dart';
import 'package:sharekhan_admin_panel/widgets/common/edit_tab_footer.dart';
import 'package:sharekhan_admin_panel/widgets/common/secondary_tab_header.dart';
import 'package:sharekhan_admin_panel/widgets/common/spacing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditSettingsScreen extends StatefulWidget {
  const EditSettingsScreen({super.key});

  @override
  State<EditSettingsScreen> createState() => _EditSettingsScreenState();
}

class _EditSettingsScreenState extends State<EditSettingsScreen> {
  bool _isLoading = true;
  late TextEditingController _androidVersionController;
  late TextEditingController _iosVersionController;
  bool _isAndroidMandatory = false;
  bool _isIOSMandatory = false;
  bool _isMaintenanceMode = false;

  Future<void> _initializeSettings() async {
    final settingProvider = context.read<SettingProvider>();
    await settingProvider.fetchSettings();
    final settings = settingProvider.settings;

    setState(() {
      _androidVersionController = TextEditingController(
          text: settings.version.androidVersion.versionName);
      _iosVersionController =
          TextEditingController(text: settings.version.iosVersion.versionName);
      _isAndroidMandatory = settings.version.androidVersion.mandatory;
      _isIOSMandatory = settings.version.iosVersion.mandatory;
      _isMaintenanceMode = settings.version.isMaintenance;
      _isLoading = false;
    });
  }

  Future<void> _saveSettings() async {
    final settingProvider = context.read<SettingProvider>();
    final updatedSettings = SettingsModel(
      version: AppVersion(
        androidVersion: Version(
          versionName: _androidVersionController.text,
          mandatory: _isAndroidMandatory,
        ),
        iosVersion: Version(
          versionName: _iosVersionController.text,
          mandatory: _isIOSMandatory,
        ),
        isMaintenance: _isMaintenanceMode,
      ),
    );

    await settingProvider.updateSettings(updatedSettings);
    router.go(Routes.settings);
  }

  @override
  void initState() {
    super.initState();
    _initializeSettings();
  }

  @override
  void dispose() {
    _androidVersionController.dispose();
    _iosVersionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? Scaffold(
            backgroundColor: AppTheme.colorWhite,
            body: SingleChildScrollView(
              padding: AppTheme.paddingSmall,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacing(size: AppTheme.spacingLarge),
                      const BreadcrumbTabHeader(
                        goBackRoute: Routes.sheruProducts,
                        mainTitle: 'Settings',
                        secondaryTitle: 'Edit Settings',
                      ),
                      const Spacing(size: AppTheme.spacingLarge),
                      const Divider(color: AppTheme.borderColor, thickness: 1),
                      const Spacing(size: AppTheme.spacingSmall),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Android Version',
                                  style: AppTheme.fontStyleDefaultBold,
                                ),
                                const Spacing(size: AppTheme.spacingTiny),
                                TextField(
                                  controller: _androidVersionController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Android Version',
                                    hintStyle:
                                        AppTheme.fontStyleDefault.copyWith(
                                      color: AppTheme.greyTextColor,
                                    ),
                                    border: AppTheme.textfieldBorder,
                                    enabledBorder: AppTheme.textfieldBorder,
                                    focusedBorder: AppTheme.textfieldBorder,
                                    filled: true,
                                    fillColor: AppTheme.colorWhite,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacing(
                              size: AppTheme.spacingMedium, isHorizontal: true),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Mandatory Update for Android',
                                  style: AppTheme.fontStyleDefaultBold,
                                ),
                                const Spacing(size: AppTheme.spacingTiny),
                                Row(
                                  children: [
                                    Switch(
                                      value: _isAndroidMandatory,
                                      onChanged: (value) {
                                        setState(() {
                                          _isAndroidMandatory = value;
                                        });
                                      },
                                      activeColor: AppTheme.colorRed,
                                    ),
                                    Text(
                                      _isAndroidMandatory ? 'Yes' : 'No',
                                      style: AppTheme.fontStyleDefault,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacing(size: AppTheme.spacingMedium),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'iOS Version',
                                  style: AppTheme.fontStyleDefaultBold,
                                ),
                                const Spacing(size: AppTheme.spacingTiny),
                                TextField(
                                  controller: _iosVersionController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter IOS Version',
                                    hintStyle:
                                        AppTheme.fontStyleDefault.copyWith(
                                      color: AppTheme.greyTextColor,
                                    ),
                                    border: AppTheme.textfieldBorder,
                                    enabledBorder: AppTheme.textfieldBorder,
                                    focusedBorder: AppTheme.textfieldBorder,
                                    filled: true,
                                    fillColor: AppTheme.colorWhite,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacing(
                              size: AppTheme.spacingMedium, isHorizontal: true),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Mandatory Update for iOS',
                                  style: AppTheme.fontStyleDefaultBold,
                                ),
                                const Spacing(size: AppTheme.spacingTiny),
                                Row(
                                  children: [
                                    Switch(
                                      value: _isIOSMandatory,
                                      onChanged: (value) {
                                        setState(() {
                                          _isIOSMandatory = value;
                                        });
                                      },
                                      activeColor: AppTheme.colorRed,
                                    ),
                                    Text(
                                      _isIOSMandatory ? 'Yes' : 'No',
                                      style: AppTheme.fontStyleDefault,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacing(size: AppTheme.spacingMedium),
                      const Divider(color: AppTheme.borderColor, thickness: 1),
                      const Spacing(size: AppTheme.spacingSmall),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Maintenance Mode',
                            style: AppTheme.fontStyleDefaultBold,
                          ),
                          const Spacing(size: AppTheme.spacingTiny),
                          Row(
                            children: [
                              Switch(
                                value: _isMaintenanceMode,
                                onChanged: (value) {
                                  setState(() {
                                    _isMaintenanceMode = value;
                                  });
                                },
                                activeColor: AppTheme.colorRed,
                              ),
                              Text(
                                _isMaintenanceMode ? 'Enabled' : 'Disabled',
                                style: AppTheme.fontStyleDefault,
                              ),
                            ],
                          ),
                          const Spacing(size: AppTheme.spacingSmall),
                          Text(
                            _isMaintenanceMode
                                ? 'The app is currently in maintenance mode.'
                                : 'The app is not in maintenance mode.',
                            style: AppTheme.fontStyleDefault,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacing(size: AppTheme.spacingLarge),
                  EditTabFooter(
                    goBackrouteName: Routes.settings,
                    onSave: _saveSettings,
                  ),
                ],
              ),
            ),
          )
        : const CustomLoading();
  }
}
