import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/constants/app_colors_path.dart';
import 'package:flutter/material.dart';

class AppTheme {
  /// Dark Theme
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColorsPath.black,
    appBarTheme: AppBarTheme(backgroundColor: AppColorsPath.black),
    cardColor: AppColorsPath.darkSurface,
    fontFamily: 'Readex Pro',
    textTheme: TextTheme(
      titleMedium: AppTextStyle.text16Medium.copyWith(
        color: AppColorsPath.brightGreen,
      ),
      titleSmall: AppTextStyle.text14Regular.copyWith(
        color: AppColorsPath.white,
      ),
      titleLarge: AppTextStyle.text32SemiBold.copyWith(
        color: AppColorsPath.lightBlack,
      ),
      bodyMedium: AppTextStyle.text14Regular.copyWith(
        color: AppColorsPath.white,
      ),
      bodyLarge: AppTextStyle.text16Medium.copyWith(
        color: AppColorsPath.white,
        fontSize: 18,
      ),
    ),
    iconTheme: IconThemeData(color: AppColorsPath.lightBlack),
    dividerColor: Colors.transparent,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColorsPath.darkSurface,
    ),
    brightness: Brightness.dark,
    primaryColor: AppColorsPath.white,
    colorScheme: ColorScheme.dark(),
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
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColorsPath.lightWhite,
    primaryColor: AppColorsPath.darkSurface,
    cardColor: AppColorsPath.white,
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
      bodyLarge: AppTextStyle.text16Medium.copyWith(
        color: AppColorsPath.black,
        fontSize: 18,
      ),
    ),
    dividerColor: Colors.grey.shade200,
    colorScheme: ColorScheme.light(),
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
