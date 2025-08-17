// lib/services/storage_service.dart
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
}
