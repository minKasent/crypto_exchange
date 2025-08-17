import 'package:crypto_exchange/core/theme/app_theme.dart';
import 'package:crypto_exchange/services/storage_service.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeData _themeData;
  late bool _isDark;

  ThemeProvider() {
    // Tải theme đã lưu khi khởi tạo Provider
    _isDark = StorageService.instance.getTheme();
    _themeData = _isDark ? AppTheme.darkTheme : AppTheme.lightTheme;
  }

  bool get isDark => _isDark;

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    _isDark = !_isDark;
    // Cập nhật theme và lưu trạng thái mới
    _themeData = _isDark ? AppTheme.darkTheme : AppTheme.lightTheme;
    StorageService.instance.setTheme(_isDark); // Lưu trạng thái theme
    notifyListeners();
  }
}