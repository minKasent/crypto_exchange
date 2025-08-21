extension StringExtension on String {
  /// convert from double to string as fixed
  /// double.parse(item.price).toStringAsFixed(2),
  /// Example: 1.23456789 -> 1.23
  String toStringAsFixed(int fractionDigits) {
    return double.parse(this).toStringAsFixed(fractionDigits);
  }
}
