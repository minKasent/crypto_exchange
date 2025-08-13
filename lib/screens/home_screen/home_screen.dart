import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/constants/app_colors_path.dart';
import 'package:crypto_exchange/core/constants/app_icons_path.dart';
import 'package:crypto_exchange/core/constants/app_images_path.dart';
import 'package:crypto_exchange/core/extensions/context_extension.dart';
import 'package:crypto_exchange/providers/home_provider.dart';
import 'package:crypto_exchange/screens/home_screen/widgets/market_mover_card.dart';
import 'package:crypto_exchange/screens/home_screen/widgets/portfolio_card.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPath.lightWhite,
      appBar: _buildAppBarWidget(),
      body: _buildBodyWidget(),
      bottomNavigationBar: _buildBottomNavigationBarWidget(),
    );
  }

  AppBar _buildAppBarWidget() {
    return AppBar(
      leading: Image.asset(AppIconsPath.iconsProfile),
      title: Image.asset(AppImagePaths.imgLogo),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Image.asset(AppIconsPath.iconsSetting),
        ),
        SizedBox(width: 10),
      ],
      backgroundColor: AppColorsPath.lightWhite,
    );
  }

  BottomNavigationBar _buildBottomNavigationBarWidget() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColorsPath.white,
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
          icon: ImageIcon(AssetImage(AppIconsPath.iconsHome)),
          activeIcon: ImageIcon(
            AssetImage(AppIconsPath.iconsHome),
            color: AppColorsPath.blue,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppIconsPath.iconsTrade)),
          activeIcon: ImageIcon(
            AssetImage(AppIconsPath.iconsTrade),
            color: AppColorsPath.blue,
          ),
          label: 'Trade',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppIconsPath.iconsMarket)),
          activeIcon: ImageIcon(
            AssetImage(AppIconsPath.iconsMarket),
            color: AppColorsPath.blue,
          ),
          label: 'Market',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppIconsPath.iconsFavorites)),
          activeIcon: ImageIcon(
            AssetImage(AppIconsPath.iconsFavorites),
            color: AppColorsPath.blue,
          ),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppIconsPath.iconsWallet)),
          activeIcon: ImageIcon(
            AssetImage(AppIconsPath.iconsWallet),
            color: AppColorsPath.blue,
          ),
          label: 'Wallet',
        ),
      ],
    );
  }

  Widget _buildBodyWidget() {
    switch (currentIndex) {
      case 0:
        return Consumer<HomeProvider>(
          builder: (_, homeProvider, __) {
            return SizedBox(
              height: context.screenHeight * 0.85,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20),
                    Image.asset(AppImagePaths.imgPortfolioGraph),
                    // MARKET MOVERS
                    _buildSectionHeader("Market Movers"),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: (172 / 812) * context.screenHeight,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: const [
                          MarketMoverCard(
                            iconPath: AppIconsPath.iconsBTC,
                            symbol: "BTC/USD",
                            price: "30,113.80",
                            change: "+2.76%",
                            isPositive: true,
                            volume: "394 897 432,26",
                            chartPath: true,
                          ),
                          SizedBox(width: 12),
                          MarketMoverCard(
                            iconPath: AppIconsPath.iconsSLA,
                            symbol: "SOL/USD",
                            price: "40,11",
                            change: "+3.75%",
                            isPositive: true,
                            volume: "150 897 992,26",
                            chartPath: false,
                          ),
                          SizedBox(width: 12),
                          MarketMoverCard(
                            iconPath: AppIconsPath.iconsETH,
                            symbol: "ETH/USD",
                            price: "1,890.45",
                            change: "-1.25%",
                            isPositive: false,
                            volume: "280 123 456,78",
                            chartPath: false,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // PORTFOLIO
                    _buildSectionHeader("Portfolio"),
                    const SizedBox(height: 16),
                    Flexible(
                      fit: FlexFit.loose,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homeProvider.listOfCoins.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = homeProvider.listOfCoins[index];
                          return PortfolioCard(
                            iconPath: AppIconsPath.iconsSLA,
                            name: item.symbolName,
                            symbol: "BTC",
                            value: item.price,
                            change: item.priceChangePercent,
                            isPositive: true,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      case 1:
        return Center(child: Text("Trade"));
      case 2:
        return Center(child: Text("Market"));
      case 3:
        return Center(child: Text("Favorites"));
      case 4:
        return Center(child: Text("Wallet"));
      default:
        return Center(child: Text("Home"));
    }
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          content: title,
          style: AppTextStyle.text16Medium.copyWith(
            color: AppColorsPath.darkBlue,
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
