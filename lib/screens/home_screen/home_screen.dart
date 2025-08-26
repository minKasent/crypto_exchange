import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/constants/app_colors_path.dart';
import 'package:crypto_exchange/core/constants/app_icons_path.dart';
import 'package:crypto_exchange/core/constants/app_images_path.dart';
import 'package:crypto_exchange/core/extensions/context_extension.dart';
import 'package:crypto_exchange/providers/home_provider.dart';
import 'package:crypto_exchange/screens/favorite/favorite_screen.dart';
import 'package:crypto_exchange/screens/home_screen/widgets/market_mover_card.dart';
import 'package:crypto_exchange/screens/home_screen/widgets/portfolio_card.dart';
import 'package:crypto_exchange/screens/trade_screen/trade_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().init();
    });
  }

  String _getCoinIcon(String symbol) {
    switch (symbol.toUpperCase()) {
      case 'BTC':
      case 'BTCUSDT':
        return AppIconsPath.iconsBTC;
      case 'ETH':
      case 'ETHUSDT':
        return AppIconsPath.iconsETH;
      case 'SOL':
      case 'SOLUSDT':
        return AppIconsPath.iconsSLA;
      default:
        return AppIconsPath.iconsBTC; // fallback icon
    }
  }

  String _formatVolume(String volume) {
    final vol = double.tryParse(volume) ?? 0;
    if (vol >= 1000000000) {
      return "${(vol / 1000000000).toStringAsFixed(2)}B";
    } else if (vol >= 1000000) {
      return "${(vol / 1000000).toStringAsFixed(2)}M";
    } else if (vol >= 1000) {
      return "${(vol / 1000).toStringAsFixed(2)}K";
    }
    return vol.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: _buildBodyWidget(),
      bottomNavigationBar: _buildBottomNavigationBarWidget(),
    );
  }

  AppBar _buildAppBarWidget() {
    return AppBar(
      leading: Image.asset(
        AppIconsPath.iconsProfile,
        color: context.theme.iconTheme.color,
      ),
      title: Image.asset(AppImagePaths.imgLogo),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, "/setting");
          },
          icon: Image.asset(
            AppIconsPath.iconsSetting,
            color: context.theme.iconTheme.color,
          ),
        ),
        const SizedBox(width: 10),
      ],
      backgroundColor: context.theme.appBarTheme.backgroundColor,
    );
  }

  Widget _buildBodyWidget() {
    switch (currentIndex) {
      case 0:
        return Consumer<HomeProvider>(
          builder: (_, homeProvider, __) {
            return Scaffold(
              appBar: _buildAppBarWidget(),
              body: SizedBox(
                height: context.screenHeight * 0.85,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            AppText(
                              content: "Portfolio Balance",
                              style: AppTextStyle.text16Medium.copyWith(
                                color:
                                    context.theme.textTheme.titleSmall!.color,
                              ),
                            ),
                            AppText(
                              content: "\$2,760.23",
                              style: AppTextStyle.text32SemiBold.copyWith(
                                color:
                                    context.theme.textTheme.titleSmall!.color,
                              ),
                            ),
                            AppText(
                              content: "+2.60%",
                              style: AppTextStyle.text16Medium.copyWith(
                                color:
                                    context.theme.textTheme.titleSmall!.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(AppImagePaths.imgPortfolioGraph),
                      // MARKET MOVERS
                      _buildSectionHeader("Market Movers"),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: (172 / 812) * context.screenHeight,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount:
                              homeProvider
                                  .listOfCoins
                                  .length, // Hiển thị tất cả coins
                          itemBuilder: (context, index) {
                            final coin = homeProvider.listOfCoins[index];
                            final changePercent =
                                double.tryParse(
                                  coin.priceChangePercent.replaceAll('%', ''),
                                ) ??
                                0;

                            return Padding(
                              padding: EdgeInsets.only(
                                right:
                                    index < homeProvider.listOfCoins.length - 1
                                        ? 12
                                        : 0,
                              ), // Padding cho tất cả items trừ item cuối
                              child: MarketMoverCard(
                                iconPath: _getCoinIcon(coin.symbol),
                                symbol: coin.symbol,
                                price: double.parse(
                                  coin.price,
                                ).toStringAsFixed(2),
                                change:
                                    "${changePercent >= 0 ? '+' : ''}${changePercent.toStringAsFixed(2)}%",
                                isPositive: changePercent >= 0,
                                volume: _formatVolume(coin.volume),
                                chartPath: changePercent >= 0,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),

                      // PORTFOLIO
                      _buildSectionHeader("Portfolio"),
                      const SizedBox(height: 16),
                      Flexible(
                        fit: FlexFit.loose,
                        child: ListView.separated(
                          separatorBuilder:
                              (context, index) => const SizedBox(height: 16),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: homeProvider.listOfCoins.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final item = homeProvider.listOfCoins[index];
                            return PortfolioCard(
                              iconPath: _getCoinIcon(item.symbol),
                              name: item.symbolName,
                              symbol: item.symbol,
                              value: double.parse(
                                item.price,
                              ).toStringAsFixed(2),
                              change: item.priceChangePercent,
                              isPositive:
                                  !item.priceChangePercent.startsWith('-'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      case 1:
        return const TradeScreen();
      case 2:
        return const Center(child: Text("Market"));
      case 3:
        return const FavoriteScreen();
      case 4:
        return const Center(child: Text("Wallet"));
      default:
        return const Center(child: Text("Home"));
    }
  }

  BottomNavigationBar _buildBottomNavigationBarWidget() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: context.theme.bottomNavigationBarTheme.backgroundColor,
      selectedItemColor: AppColorsPath.blue,
      unselectedItemColor: AppColorsPath.grey,
      elevation: 10,
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage(AppIconsPath.iconsHome),
            color: context.theme.iconTheme.color,
          ),
          activeIcon: ImageIcon(
            AssetImage(AppIconsPath.iconsHome),
            color: AppColorsPath.blue,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage(AppIconsPath.iconsTrade),
            color: context.theme.iconTheme.color,
          ),
          activeIcon: ImageIcon(
            AssetImage(AppIconsPath.iconsTrade),
            color: AppColorsPath.blue,
          ),
          label: 'Trade',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage(AppIconsPath.iconsMarket),
            color: context.theme.iconTheme.color,
          ),
          activeIcon: ImageIcon(
            AssetImage(AppIconsPath.iconsMarket),
            color: AppColorsPath.blue,
          ),
          label: 'Market',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage(AppIconsPath.iconsFavorites),
            color: context.theme.iconTheme.color,
          ),
          activeIcon: ImageIcon(
            AssetImage(AppIconsPath.iconsFavorites),
            color: AppColorsPath.blue,
          ),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage(AppIconsPath.iconsWallet),
            color: context.theme.iconTheme.color,
          ),
          activeIcon: ImageIcon(
            AssetImage(AppIconsPath.iconsWallet),
            color: AppColorsPath.blue,
          ),
          label: 'Wallet',
        ),
      ],
    );
  }

  Row _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          content: title,
          style: AppTextStyle.text16Medium.copyWith(
            color: context.theme.textTheme.titleSmall!.color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppText(
          content: "More",
          style: AppTextStyle.text16Medium.copyWith(color: AppColorsPath.blue),
        ),
      ],
    );
  }
}
