import 'package:flutter/material.dart';
import 'package:sharekhan_admin_panel/globals.dart';
import 'package:sharekhan_admin_panel/models/settings_model.dart';

class SettingProvider extends ChangeNotifier {
  late SettingsModel _settings;
  SettingsModel get settings => _settings;

  Future<void> fetchSettings() async {
    final querySnapshot = await settingsRef.doc('appSettings').get();
    _settings = SettingsModel.fromMap(querySnapshot.data()!);
    notifyListeners();
  }

  Future<void> updateSettings(SettingsModel settings) async {
    await settingsRef.doc('appSettings').update(settings.toMap());
    _settings = settings;
    notifyListeners();
  }

  Future<void> updateMaintainance(bool isMaintenance) async {
    _settings = settings.copyWith(
        version: settings.version.copyWith(isMaintenance: isMaintenance));
    await settingsRef.doc('appSettings').update(_settings.toMap());
    notifyListeners();
  }
}
