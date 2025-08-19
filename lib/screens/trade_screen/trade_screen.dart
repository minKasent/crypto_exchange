import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/core/constants/app_icons_path.dart';
import 'package:crypto_exchange/core/extensions/context_extension.dart';
import 'package:crypto_exchange/routes/app_routes.dart';
import 'package:crypto_exchange/screens/trade_screen/widgets/orderbook_number_widget.dart';
import 'package:crypto_exchange/screens/trade_screen/widgets/trade_appbar_widget.dart';
import 'package:crypto_exchange/screens/trading_chart/trading_chart_screen.dart';
import 'package:flutter/material.dart';

class TradeScreen extends StatefulWidget {
  const TradeScreen({super.key});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        currentIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TradeAppbarWidget(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.screenWidth - 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(9),
            ),
            child: TabBar(
              controller: _tabController,
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              tabAlignment: TabAlignment.center,
              padding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              labelPadding: EdgeInsets.all(2),
              tabs: [
                Container(
                  width: 85,
                  height: 28,
                  decoration:
                      currentIndex == 0
                          ? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          )
                          : null,
                  alignment: Alignment.center,
                  child: Text("Spot", style: TextStyle(color: Colors.black)),
                ),
                Container(
                  width: 85,
                  height: 28,
                  decoration:
                      currentIndex == 1
                          ? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          )
                          : null,
                  alignment: Alignment.center,
                  child: Text("Margin", style: TextStyle(color: Colors.black)),
                ),
                Container(
                  width: 85,
                  height: 28,
                  decoration:
                      currentIndex == 2
                          ? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          )
                          : null,
                  alignment: Alignment.center,
                  child: Text("Grid", style: TextStyle(color: Colors.black)),
                ),
                Container(
                  width: 85,
                  height: 28,
                  decoration:
                      currentIndex == 3
                          ? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          )
                          : null,
                  alignment: Alignment.center,
                  child: Text("Fiat", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: [
                Column(
                  children: [
                    SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 16),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AppText(
                                  content: "BTC/USDT",
                                  style: context.theme.textTheme.titleSmall!
                                      .copyWith(color: Colors.black),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_drop_down),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                AppText(
                                  content: "30,113.80",
                                  style: context.theme.textTheme.titleSmall!
                                      .copyWith(color: Colors.black),
                                ),
                                AppText(
                                  content: "≈\$30,113.80",
                                  style: context.theme.textTheme.titleSmall!
                                      .copyWith(color: Colors.black),
                                ),
                                AppText(
                                  content: "+2.76%",
                                  style: context.theme.textTheme.titleSmall!
                                      .copyWith(color: Colors.black),
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

                                /// TODO: pass args coin symbol
                                arguments: 'ETHUSDT',
                              ),
                          // () => Navigator.push(context, MaterialPageRoute(builder: (context) => TradingChartScreen(symbol: 'ETHUSDT'))),
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 16),
                        SizedBox(
                          width: (145 / 375) * context.screenWidth,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    content: "Order bk No.",
                                    style: context.theme.textTheme.titleSmall!
                                        .copyWith(color: Colors.black),
                                  ),
                                  AppText(
                                    content: "Unit",
                                    style: context.theme.textTheme.titleSmall!
                                        .copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  OrderbookNumberWidget(content: '10'),
                                  const Spacer(),
                                  OrderbookNumberWidget(
                                    content: '0.00001',
                                    horizontalPadding: 6,
                                  ),
                                ],
                              ),
                              SizedBox(height: 11),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppText(
                                    content: "Price",
                                    style: context.theme.textTheme.titleSmall!
                                        .copyWith(color: Colors.black),
                                  ),
                                  AppText(
                                    content: "Amount",
                                    style: context.theme.textTheme.titleSmall!
                                        .copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              ListView.separated(
                                itemCount: 10,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                separatorBuilder:
                                    (context, index) => SizedBox(height: 4),
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        content: "30,113.84",
                                        style: context
                                            .theme
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(color: Colors.black),
                                      ),
                                      AppText(
                                        content: "1,76676",
                                        style: context
                                            .theme
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(color: Colors.black),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 11),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                padding: EdgeInsets.all(2),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(
                                            9,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 6,
                                        ),
                                        child: AppText(
                                          content: "Buy",
                                          style: context
                                              .theme
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(
                                            9,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 6,
                                        ),
                                        child: AppText(
                                          content: "Sell",
                                          style: context
                                              .theme
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      content: "Buy",
                                      style: context.theme.textTheme.titleSmall!
                                          .copyWith(color: Colors.black),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Image.asset(
                                        AppIconsPath.iconsBack,
                                        width: 7,
                                        height: 7,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              AppText(
                                content: "Available:",
                                style: context.theme.textTheme.titleSmall!
                                    .copyWith(color: Colors.black),
                              ),
                              SizedBox(height: 4),
                              AppText(
                                content: "1000 USD",
                                style: context.theme.textTheme.titleSmall!
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 299,
                  height: 299,
                  color: Colors.red,
                  child: Center(child: Text("hello")),
                ),
                Container(
                  width: 299,
                  height: 299,
                  color: Colors.red,
                  child: Center(child: Text("hello")),
                ),
                Container(
                  width: 299,
                  height: 299,
                  color: Colors.red,
                  child: Center(child: Text("hello")),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
