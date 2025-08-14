import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/constants/app_colors_path.dart';
import 'package:flutter/material.dart';

class AppTheme {
  /// Dark Theme
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColorsPath.black,
    appBarTheme: AppBarTheme(backgroundColor: AppColorsPath.black),
    textTheme: TextTheme(
      titleMedium: AppTextStyle.text16Medium.copyWith(
        color: AppColorsPath.white,
      ),
      titleSmall: AppTextStyle.text14Regular.copyWith(
        color: AppColorsPath.white,
      ),
      titleLarge: AppTextStyle.text32SemiBold.copyWith(
        color: AppColorsPath.white,
      ),
    ),
    primaryColor: AppColorsPath.white,
    typography: Typography(
      white: TextTheme(
        titleMedium: AppTextStyle.text16Medium.copyWith(
          color: AppColorsPath.white,
        ),
        titleSmall: AppTextStyle.text14Regular.copyWith(
          color: AppColorsPath.white,
        ),
        titleLarge: AppTextStyle.text32SemiBold.copyWith(
          color: AppColorsPath.white,
        ),
      ),
    ),
  );

  /// Light Theme
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColorsPath.lightWhite,
    primaryColor: AppColorsPath.darkSurface,
    appBarTheme: AppBarTheme(backgroundColor: AppColorsPath.white),
    textTheme: TextTheme(
      titleMedium: AppTextStyle.text16Medium.copyWith(
        color: AppColorsPath.black,
      ),
      titleSmall: AppTextStyle.text14Regular.copyWith(
        color: AppColorsPath.black,
      ),
      titleLarge: AppTextStyle.text32SemiBold.copyWith(
        color: AppColorsPath.black,
      ),
    ),
    typography: Typography(
      white: TextTheme(
        titleMedium: AppTextStyle.text16Medium.copyWith(
          color: AppColorsPath.black,
        ),
        titleSmall: AppTextStyle.text14Regular.copyWith(
          color: AppColorsPath.black,
        ),
        titleLarge: AppTextStyle.text32SemiBold.copyWith(
          color: AppColorsPath.black,
        ),
      ),
    ),
  );
}
