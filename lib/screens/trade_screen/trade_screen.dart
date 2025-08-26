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

        final isPositive = double.parse(coin.priceChangePercent) > 0;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const ListCoinsBottomSheet();
                        },
                      );
                    },
                    child: Row(
                      children: [
                        AppText(
                          content: coin.symbolName,
                          style: AppTextStyle.text16Medium.copyWith(
                            color: context.titleSmallColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColorsPath.grey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppText(
                        content: double.parse(coin.price).toStringAsFixed(2),
                        style: AppTextStyle.text16Medium.copyWith(
                          color:
                              isPositive
                                  ? AppColorsPath.green
                                  : AppColorsPath.red,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: AppText(
                          content:
                              "≈\$${double.parse(coin.price).toStringAsFixed(2)}",
                          style: AppTextStyle.text14Regular.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: AppText(
                          content:
                              "${isPositive ? "+" : ""}${double.parse(coin.priceChangePercent).toStringAsFixed(2)}%",
                          style: AppTextStyle.text14Regular.copyWith(
                            color:
                                isPositive
                                    ? AppColorsPath.green
                                    : AppColorsPath.red,
                          ),
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  content: "Select Trading Pair",
                  style: AppTextStyle.text16Medium.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                  hintText: "Search coins...",
                  hintStyle: AppTextStyle.text14Regular.copyWith(
                    color: Colors.grey[400],
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          // Coins list
          Expanded(
            child: Consumer<HomeProvider>(
              builder: (context, homeProvider, child) {
                if (homeProvider.listOfCoins.isEmpty) {
                  return const Center(
                    child: AppText(content: "No coins available"),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final coin = homeProvider.listOfCoins[index];
                    final isSelected =
                        coin.symbol.toLowerCase() ==
                        tradeProvider.currentSymbol;
                    final isPositive =
                        double.parse(coin.priceChangePercent) > 0;

                    return InkWell(
                      onTap: () {
                        if (!isSelected) {
                          tradeProvider.connectToOrderBookStream(coin.symbol);
                        }
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? Colors.blue.withOpacity(0.1)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              isSelected
                                  ? Border.all(
                                    color: Colors.blue.withOpacity(0.3),
                                  )
                                  : null,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        child: Row(
                          children: [
                            // Coin info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    content: coin.symbolName,
                                    style: AppTextStyle.text16Medium.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color:
                                          isSelected
                                              ? Colors.blue
                                              : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  AppText(
                                    content: coin.symbol.toUpperCase(),
                                    style: AppTextStyle.text14Regular.copyWith(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Price info
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                AppText(
                                  content:
                                      "\$${double.parse(coin.price).toStringAsFixed(2)}",
                                  style: AppTextStyle.text14Regular.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (isPositive
                                            ? AppColorsPath.green
                                            : AppColorsPath.red)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: AppText(
                                    content:
                                        "${isPositive ? "+" : ""}${double.parse(coin.priceChangePercent).toStringAsFixed(2)}%",
                                    style: AppTextStyle.text14Regular.copyWith(
                                      color:
                                          isPositive
                                              ? AppColorsPath.green
                                              : AppColorsPath.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (isSelected) ...[
                              const SizedBox(width: 8),
                              Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 20,
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 4),
                  itemCount: homeProvider.listOfCoins.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BuySellWidget extends StatefulWidget {
  const BuySellWidget({super.key});

  @override
  State<BuySellWidget> createState() => _BuySellWidgetState();
}

class _BuySellWidgetState extends State<BuySellWidget> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _priceController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TradeProvider>(
      builder: (context, tradeProvider, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBuySellButtonsRow(tradeProvider),
              const SizedBox(height: 16),
              _buildDropdown("Limit", context),
              const SizedBox(height: 12),
              _buildAvailableBalance(),
              const SizedBox(height: 12),
              _buildAmountInputWidget("Prace", "USDT", _priceController),
              const SizedBox(height: 8),
              _buildAmountInputWidget("Amount", "BTC", _amountController),
              const SizedBox(height: 16),
              _buildSlider(tradeProvider),
              const SizedBox(height: 8),
              _buildTotalInput("0", context),
              const SizedBox(height: 16),
              _buildOrderButton(tradeProvider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBuySellButtonsRow(TradeProvider provider) {
    final isBuy = provider.isBuy;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => provider.toggleBuySell(true),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 40,
              decoration: BoxDecoration(
                color: isBuy ? AppColorsPath.blue : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: AppText(
                  content: "Buy",
                  style: AppTextStyle.text14Regular.copyWith(
                    color: isBuy ? Colors.white : Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => provider.toggleBuySell(false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 40,
              decoration: BoxDecoration(
                color: !isBuy ? AppColorsPath.red : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: AppText(
                  content: "Sell",
                  style: AppTextStyle.text14Regular.copyWith(
                    color: !isBuy ? Colors.white : Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvailableBalance() {
    return AppText(
      content: "Available: 1000 USDT",
      style: AppTextStyle.text14Regular.copyWith(color: AppColorsPath.grey),
    );
  }

  Widget _buildAmountInputWidget(
    String label,
    String suffix,
    TextEditingController controller,
  ) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              textAlign: TextAlign.start,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '— $label',
                hintStyle: AppTextStyle.text14Regular.copyWith(
                  color: AppColorsPath.grey,
                ),
              ),
            ),
          ),
          AppText(
            content: '$suffix +',
            style: AppTextStyle.text14Regular.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(TradeProvider provider) {
    return Row(
      children: [
        AppText(
          content: "${provider.sliderValue.round()}%",
          style: AppTextStyle.text14Regular.copyWith(
            fontSize: 12,
            color: AppColorsPath.grey,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Slider(
            value: provider.sliderValue,
            min: 0,
            max: 100,
            activeColor: AppColorsPath.blue,
            inactiveColor: Colors.grey[300],
            onChanged: provider.setSliderValue,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderButton(TradeProvider provider) {
    return AppButton(
      title: provider.isBuy ? 'Buy BTC' : 'Sell BTC',
      backgroundColor: provider.isBuy ? AppColorsPath.blue : AppColorsPath.red,
      buttonState: ButtonState.normal,
      onTap: _handleOrderSubmit,
    );
  }

  void _handleOrderSubmit() {}

  Widget _buildDropdown(String value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            content: value,
            style: AppTextStyle.text14Regular.copyWith(color: Colors.black),
          ),
          Icon(Icons.keyboard_arrow_down, color: AppColorsPath.grey),
        ],
      ),
    );
  }

  Widget _buildTotalInput(String value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            content: value,
            style: AppTextStyle.text14Regular.copyWith(
              color: AppColorsPath.grey,
            ),
          ),
          AppText(
            content: "USDT",
            style: AppTextStyle.text14Regular.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
