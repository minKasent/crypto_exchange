import 'package:crypto_exchange/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = AppTheme.lightTheme;
  bool _isDark = false;

  bool get isDark => _isDark;

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    _isDark = !_isDark;
    _themeData = isDark ? AppTheme.darkTheme : AppTheme.lightTheme;
    notifyListeners();
  }
}
