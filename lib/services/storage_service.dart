import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  /// Init Storage Service instance
  StorageService._internal();
  static final StorageService _instance = StorageService._internal();
  static StorageService get instance => _instance;

  /// declare key
  static const String onboardingKey = "onboarding_completed_key";

  late SharedPreferences _sharedPreferences;

  /// Init Share preferences
  Future<void> initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// global function to set bool function by key and value
  Future<void> setBoolValue(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }

  /// global function to get bool function by key
  bool getBoolValue(String key) {
    return _sharedPreferences.getBool(key) ?? false;
  }

  /// set onboarding value
  Future<void> setOnboardingCompleted(bool value) async {
    await setBoolValue(onboardingKey, value);
  }

  /// get onboarindg value
  bool getOnboardingCompleted() {
    return getBoolValue(onboardingKey);
  }
}
