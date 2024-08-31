// lib/providers/theme_provider.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'models/role.dart';

class ThemeProvider extends ChangeNotifier {
  Persona _persona = Persona.Adult;
  bool _isDarkMode = false;

  ThemeData get currentTheme =>
      _isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme;

  LinearGradient get currentGradient {
    switch (_persona) {
      case Persona.Kids:
        return AppThemes.kidsGradient;
      case Persona.Teen:
        return AppThemes.teenGradient;
      case Persona.Adult:
      default:
        return AppThemes.adultGradient;
    }
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String personaString =
        prefs.getString('persona') ?? Persona.Adult.toString();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _persona = Persona.values.firstWhere((e) => e.toString() == personaString);
    notifyListeners();
  }

  Future<void> updatePersona(Persona newPersona) async {
    _persona = newPersona;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('persona', _persona.toString());
    notifyListeners();
  }

  Future<void> toggleDarkMode(bool isDark) async {
    _isDarkMode = isDark;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  Persona get persona => _persona;
  bool get isDarkMode => _isDarkMode;
}
