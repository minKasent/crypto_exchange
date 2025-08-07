import 'package:crypto_exchange/providers/coin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DemoHomeScreen extends StatelessWidget {
  const DemoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CoinProvider(),
      child: _DemoHomeScreenView(),
    );
  }
}

class _DemoHomeScreenView extends StatefulWidget {
  const _DemoHomeScreenView();

  @override
  State<_DemoHomeScreenView> createState() => _DemoHomeScreenViewState();
}

class _DemoHomeScreenViewState extends State<_DemoHomeScreenView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<CoinProvider>().init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoinProvider>(
      builder: (_, coinProvider, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Demo Stream")],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: coinProvider.listOfCoins.length,
                  itemBuilder: (context, index) {
                    final coin = coinProvider.listOfCoins[index];
                    return Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [Text(coin.symbolName), Text("Data")],
                          ),
                          Column(
                            children: [
                              Text(coin.price),
                              Text(coin.priceChangePercent),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
