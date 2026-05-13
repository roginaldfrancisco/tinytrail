import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/app_themes.dart';

class ThemeProvider extends ChangeNotifier {
  String _currentTheme = 'daylight';

  String get currentTheme => _currentTheme;

  ThemeData get themeData {
    if (_currentTheme == 'starlight') {
      return AppThemes.starlight;
    }

    if (_currentTheme == 'candy') {
      return AppThemes.candy;
    }

    return AppThemes.daylight;
  }

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    _currentTheme = prefs.getString('app_theme') ?? 'daylight';

    notifyListeners();
  }

  Future<void> setTheme(String theme) async {
    _currentTheme = theme;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('app_theme', theme);

    notifyListeners();
  }
}