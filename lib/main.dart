import 'package:crypto_exchange/providers/home_provider.dart';
import 'package:crypto_exchange/providers/theme_provider.dart';
import 'package:crypto_exchange/repositories/coin_respository.dart';
import 'package:crypto_exchange/routes/app_routes.dart';
import 'package:crypto_exchange/services/binance_websocket_service.dart';
import 'package:crypto_exchange/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instance.initSharedPreferences();
  bool onboardingCompleted = StorageService.instance.getOnboardingCompleted();
  runApp(CryptoExchange(onboardingCompleted: onboardingCompleted));
}

class CryptoExchange extends StatelessWidget {
  final bool onboardingCompleted;
  const CryptoExchange({super.key, required this.onboardingCompleted});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        Provider(create: (context) => BinanceWebsocketService()),
        Provider(
          create:
              (context) =>
                  CoinRespository(context.read<BinanceWebsocketService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(context.read<CoinRespository>()),
        ),
      ],
      child: MyApp(onboardingCompleted: onboardingCompleted),
    );
  }
}

class MyApp extends StatelessWidget {
  final bool onboardingCompleted;
  const MyApp({super.key, required this.onboardingCompleted});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: AppRoutes.routes,
      theme: context.watch<ThemeProvider>().themeData,
      initialRoute:
          onboardingCompleted
              ? AppRoutes.homeScreen
              : AppRoutes.onboardingScreen,
    );
  }
}
