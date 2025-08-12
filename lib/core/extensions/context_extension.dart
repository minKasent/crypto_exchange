import 'package:flutter/material.dart';

/// Context Extension
extension ContextExtension on BuildContext {
  /// get screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// get theme
  ThemeData get theme => Theme.of(this);
}
