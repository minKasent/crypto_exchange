import 'package:crypto_exchange/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = AppTheme.lightTheme;// default theme == light theme
  bool _isDark = false; // default isDark == false

  bool get isDark => _isDark;

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    _isDark = !_isDark; // đảo ngược trạng thái isDark
    // cập nhật _themeData dựa trên trạng thái isDark
    _themeData = isDark ? AppTheme.darkTheme : AppTheme.lightTheme; // set the theme data based on the isDark state
    notifyListeners();
  }
}
