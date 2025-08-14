import 'package:crypto_exchange/screens/home_screen/home_screen.dart';
import 'package:crypto_exchange/screens/setting_screen/setting_screen.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes {
  static const String settingScreen = '/setting';

  static final Map<String, WidgetBuilder> routes = {
    settingScreen: (context) => const SettingScreen(),
  };
}