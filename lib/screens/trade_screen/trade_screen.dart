// lib/screens/trade_screen/trade_screen.dart
import 'package:crypto_exchange/components/app_button.dart';
import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/constants/app_colors_path.dart';
import 'package:crypto_exchange/core/enum/enum.dart';
import 'package:crypto_exchange/core/extensions/context_extension.dart';
import 'package:crypto_exchange/models/coin.dart';
import 'package:crypto_exchange/providers/home_provider.dart';
import 'package:crypto_exchange/providers/trade_provider.dart';
import 'package:crypto_exchange/routes/app_routes.dart';
import 'package:crypto_exchange/screens/trade_screen/widgets/order_book_widget.dart';
import 'package:crypto_exchange/screens/trade_screen/widgets/trade_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TradeAppbarWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                color: context.theme.cardColor.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(9),
              ),
              child: TabBar(
                controller: _tabController,
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                tabAlignment: TabAlignment.fill,
                labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                onTap: (index) => setState(() {}),
                tabs:
                    ["Spot", "Margin", "Grid", "Fiat"]
                        .asMap()
                        .entries
                        .map((entry) => _buildTab(entry.value, entry.key))
                        .toList(),
              ),
            ),
          ),
          _buildCoinInfoHeader(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSpotTradingView(),
                const Center(child: AppText(content: "Margin Screen")),
                const Center(child: AppText(content: "Grid Screen")),
                const Center(child: AppText(content: "Fiat Screen")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Tab _buildTab(String title, int index) {
    return Tab(
      child: Center(
        child: AppText(
          content: title,
          style: AppTextStyle.text14Regular.copyWith(
            color:
                _tabController.index == index
                    ? Colors.black
                    : AppColorsPath.grey,
          ),
        ),
      ),
    );
  }

  Consumer<HomeProvider> _buildCoinInfoHeader() {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        if (homeProvider.listOfCoins.isEmpty) {
          return const SizedBox(
            height: 60,
            child: Center(child: AppText(content: "Waiting for coin data...")),
          );
        }
        Coin coin =
            homeProvider.listOfCoins
                .where(
                  (e) =>
                      e.symbol.toLowerCase() ==
                      context.read<TradeProvider>().currentSymbol,
                )
                .toList()
                .first;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppText(
                        content: coin.symbolName,
                        style: AppTextStyle.text16Medium.copyWith(
                          color: context.titleSmallColor,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 4),
                      InkWell(
                        /// Show bottomsheet to display list 20 coins
                        onTap: () async {
                          await showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return ListCoinsBottomSheet();
                            },
                          );
                        },
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColorsPath.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      AppText(
                        content:
                            "\$${double.parse(coin.price).toStringAsFixed(2)} ",
                        style: AppTextStyle.text16Medium.copyWith(
                          color: context.titleSmallColor,
                          fontSize: 18,
                        ),
                      ),
                      AppText(
                        content:
                            "≈\$${double.parse(coin.price).toStringAsFixed(2)}",
                        style: AppTextStyle.text14Regular.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      AppText(
                        content:
                            "${double.parse(coin.priceChangePercent) > 0 ? "+" : ""}${double.parse(coin.priceChangePercent).toStringAsFixed(2)}%",
                        style: AppTextStyle.text14Regular.copyWith(
                          color:
                              double.parse(coin.priceChangePercent) > 0
                                  ? AppColorsPath.green
                                  : AppColorsPath.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed:
                    () => Navigator.pushNamed(
                      context,
                      AppRoutes.tradingChartScreen,
                      arguments: coin.symbol,
                    ),
                icon: const Icon(Icons.show_chart),
              ),
            ],
          ),
        );
      },
    );
  }

  Padding _buildSpotTradingView() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: OrderBookWidget()),
          SizedBox(width: 12),
          Expanded(flex: 1, child: BuySellWidget()),
        ],
      ),
    );
  }
}

class ListCoinsBottomSheet extends StatelessWidget {
  const ListCoinsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final tradeProvider = context.watch<TradeProvider>();
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        return ListView.separated(
          padding: EdgeInsets.all(12),
          itemBuilder: (context, index) {
            final coin = homeProvider.listOfCoins[index];
            return InkWell(
              onTap: () {
                if (coin.symbol.toLowerCase() != tradeProvider.currentSymbol) {
                  tradeProvider.connectToOrderBookStream(coin.symbol);
                }
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      content: coin.symbolName,
                      style: AppTextStyle.text14Regular,
                    ),
                    AppText(
                      content: coin.price,
                      style: AppTextStyle.text14Regular,
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemCount: homeProvider.listOfCoins.length,
        );
      },
    );
  }
}

class BuySellWidget extends StatelessWidget {
  const BuySellWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TradeProvider>(
      builder: (context, tradeProvider, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 32,
                decoration: BoxDecoration(
                  color: AppColorsPath.grey.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    _buildBuySellButton("Buy", true, tradeProvider, context),
                    _buildBuySellButton("Sell", false, tradeProvider, context),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              _buildDropdown("Limit", context),
              const SizedBox(height: 12),
              AppText(
                content: "Available: 1000 USDT",
                style: AppTextStyle.text14Regular.copyWith(
                  color: AppColorsPath.grey,
                ),
              ),

              const SizedBox(height: 12),
              _buildAmountInputWidget("Price", "USDT", context),
              const SizedBox(height: 8),
              _buildAmountInputWidget("Amount", "BTC", context),
              const SizedBox(height: 16),
              _buildSlider(tradeProvider),
              const SizedBox(height: 8),
              _buildTotalInput("0", context),
              const SizedBox(height: 16),
              AppButton(
                title: "${tradeProvider.isBuy ? 'Buy' : 'Sell'} BTC",
                buttonState: ButtonState.normal,
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  Expanded _buildBuySellButton(
    String title,
    bool isBuyButton,
    TradeProvider provider,
    BuildContext context,
  ) {
    final isSelected = provider.isBuy == isBuyButton;
    return Expanded(
      child: GestureDetector(
        onTap: () => provider.toggleBuySell(isBuyButton),
        child: Container(
          decoration: BoxDecoration(
            color:
                isSelected
                    ? (isBuyButton ? AppColorsPath.green : AppColorsPath.red)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: AppText(
              content: title,
              style: AppTextStyle.text14Regular.copyWith(
                color: isSelected ? Colors.white : AppColorsPath.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColorsPath.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColorsPath.grey.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            content: value,
            style: AppTextStyle.text14Regular.copyWith(
              color: context.titleSmallColor,
            ),
          ),
          Icon(Icons.keyboard_arrow_down, color: AppColorsPath.grey),
        ],
      ),
    );
  }

  Container _buildAmountInputWidget(
    String label,
    String suffix,
    BuildContext context,
  ) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColorsPath.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColorsPath.grey.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.remove, color: AppColorsPath.grey),
          ),
          Expanded(
            child: TextField(
              controller: TextEditingController(),
              textAlign: TextAlign.center,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: label,
                hintStyle: AppTextStyle.text14Regular.copyWith(
                  color: AppColorsPath.grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: AppText(
              content: suffix,
              style: AppTextStyle.text14Regular.copyWith(
                color: context.titleSmallColor,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add, color: AppColorsPath.grey),
          ),
        ],
      ),
    );
  }

  Container _buildSlider(TradeProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColorsPath.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColorsPath.grey.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Slider(
            value: provider.sliderValue,
            min: 0,
            max: 100,
            divisions: 4,
            activeColor: AppColorsPath.blue,
            inactiveColor: Colors.grey[200],
            onChanged: (value) => provider.setSliderValue(value),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children:
          //         ["0%", "25%", "50%", "75%", "100%"]
          //             .map(
          //               (label) => AppText(
          //                 content: label,
          //                 style: AppTextStyle.text14Regular.copyWith(
          //                   color: AppColorsPath.grey,
          //                 ),
          //               ),
          //             )
          //             .toList(),
          //   ),
          // ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Container _buildTotalInput(String value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColorsPath.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColorsPath.grey.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            content: "Total",
            style: AppTextStyle.text14Regular.copyWith(
              color: AppColorsPath.grey,
            ),
          ),
          AppText(
            content: "$value USDT",
            style: AppTextStyle.text14Regular.copyWith(
              color: context.titleSmallColor,
            ),
          ),
        ],
      ),
    );
  }
}
