import 'package:flutter/material.dart';

class SettingCategoryItemModel {
  final String iconPath;
  final String title;
  final Function(BuildContext context) onTap;
  final bool isDarkMode;

  SettingCategoryItemModel({
    required this.iconPath,
    required this.title,
    required this.onTap,
    this.isDarkMode = false,
  });
}
