// lib/services/storage_service.dart
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  /// Init Storage Service instance
  StorageService._internal();
  static final StorageService _instance =
      StorageService._internal(); // singleton instance
  static StorageService get instance => _instance; // factory constructor

  /// declare key
  static const String onboardingKey =
      "onboarding_completed_key"; // key onboarding completed
  static const String themeKey = "theme_key"; // key theme
  static const String favoriteSymbolsKey = 'favorite_symbol_key';

  // Stream controller for favorite symbol changes
  final StreamController<List<String>> _favoriteChangeController =
      StreamController<List<String>>.broadcast();

  // Stream that emits whenever favorite tokens change
  Stream<List<String>> get favoriteChangeStream =>
      _favoriteChangeController.stream;

  late SharedPreferences _sharedPreferences;

  /// Init Share preferences
  Future<void> initSharedPreferences() async {
    _sharedPreferences =
        await SharedPreferences.getInstance(); // get instance default of SharedPreferences
  }

  /// global function to set bool function by key and value
  Future<void> setBoolValue(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }

  /// global function to get bool function by key
  bool getBoolValue(String key) {
    return _sharedPreferences.getBool(key) ?? false;
  }

  /// set theme value
  Future<void> setTheme(bool isDark) async {
    await setBoolValue(themeKey, isDark);
  }

  /// get theme value
  bool getTheme() {
    return getBoolValue(themeKey);
  }

  /// set onboarding value
  Future<void> setOnboardingCompleted(bool value) async {
    await setBoolValue(onboardingKey, value);
  }

  /// get onboarding value
  bool getOnboardingCompleted() {
    return getBoolValue(
      onboardingKey,
    ); // APP -> getOnboardingCompleted() -> getBoolvalue
  }

  /// get favorite tokens list by lowercase
  /// Example if storage is [BTCUSDT, ETHUSDT] -> [btcusdt, ethusdt]
  List<String> getFavoriteTokens() {
    List<String> listOfFavoriteTokens =
        _sharedPreferences.getStringList(favoriteSymbolsKey) ?? [];

    /// To lowercase for every item in the list
    for (var i = 0; i < listOfFavoriteTokens.length; i++) {
      listOfFavoriteTokens[i] = listOfFavoriteTokens[i].toLowerCase();
    }

    return listOfFavoriteTokens;
  }

  /// Toggle favorite token
  /// Check if token is exist -> remove it from favorite list
  /// otherwise -> add it to favorite list
  Future<void> toggleFavoriteToken(String tokenSymbol) async {
    final String normalizedTokenSymbol = tokenSymbol.toLowerCase();

    List<String> currentFavoriteTokens = getFavoriteTokens();

    if (currentFavoriteTokens.contains(normalizedTokenSymbol)) {
      /// delete if token is existed in the favorite list
      currentFavoriteTokens.remove(normalizedTokenSymbol);
    } else {
      currentFavoriteTokens.insert(0, normalizedTokenSymbol);
    }

    /// save the new favorite list
    await _sharedPreferences.setStringList(
      favoriteSymbolsKey,
      currentFavoriteTokens,
    );

    /// emit the new favorite list
    _favoriteChangeController.add(currentFavoriteTokens);
  }
}
