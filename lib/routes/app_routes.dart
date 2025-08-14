import 'package:crypto_exchange/screens/home_screen/home_screen.dart';
import 'package:crypto_exchange/screens/onboarding_screen/onboarding_screen.dart';
import 'package:crypto_exchange/screens/setting_screen/setting_screen.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes {
  static const String settingScreen = '/setting';
  static const String onboardingScreen = '/onboarding';
  static const String homeScreen = '/home';
  static const String favoriteScreen = '/favorite';
  static const String tradeScreen = '/trade';
  static const String marketScreen = '/market';
  static const String walletScreen = '/wallet';

  static final Map<String, WidgetBuilder> routes = {
    settingScreen: (context) => const SettingScreen(),
    onboardingScreen: (context) => const OnboardingScreen(),
    homeScreen: (context) => const HomeScreen(),
  };
}
