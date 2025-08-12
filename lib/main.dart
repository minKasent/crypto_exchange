import 'package:crypto_exchange/providers/home_provider.dart';
import 'package:crypto_exchange/repositories/coin_respository.dart';
import 'package:crypto_exchange/screens/home_screen/home_screen.dart';
import 'package:crypto_exchange/screens/onboarding_screen/onboarding_screen.dart';
import 'package:crypto_exchange/services/binance_websocket_service.dart';
import 'package:crypto_exchange/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instance.initSharedPreferences();
  bool onboardingCompleted = StorageService.instance.getOnboardingCompleted();
  runApp(MyApp(onboardingCompleted: onboardingCompleted));
}

class MyApp extends StatelessWidget {
  final bool onboardingCompleted;
  const MyApp({super.key, required this.onboardingCompleted});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: 'Readex Pro',
        ),
        home:
            onboardingCompleted ? const HomeScreen() : const OnboardingScreen(),
      ),
    );
  }
}
