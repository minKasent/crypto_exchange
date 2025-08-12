import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/constants/app_colors_path.dart';
import 'package:crypto_exchange/constants/app_icons_path.dart';
import 'package:crypto_exchange/constants/app_images_path.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPath.lightWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset(AppImagePaths.logo)],
            ),
            SizedBox(height: 20),
            Image.asset(AppImagePaths.img_portfolio_graph),
            // MARKET MOVERS
            _buildSectionHeader("Market Movers"),
            const SizedBox(height: 16),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _MarketMoverCard(
                    iconPath: AppIconsPath.iconsBTC,
                    symbol: "BTC/USD",
                    price: "30,113.80",
                    change: "+2.76%",
                    isPositive: true,
                    volume: "394 897 432,26",
                  ),
                  SizedBox(width: 12),
                  _MarketMoverCard(
                    iconPath: AppIconsPath.iconsSLA,
                    symbol: "SOL/USD",
                    price: "40,11",
                    change: "+3.75%",
                    isPositive: true,
                    volume: "150 897 992,26",
                  ),
                  SizedBox(width: 12),
                  _MarketMoverCard(
                    iconPath: AppIconsPath.iconsETH,
                    symbol: "ETH/USD",
                    price: "1,890.45",
                    change: "-1.25%",
                    isPositive: false,
                    volume: "280 123 456,78",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // PORTFOLIO
            _buildSectionHeader("Portfolio"),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: AppColorsPath.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: const [
                  _PortfolioCoinTile(
                    iconPath: AppIconsPath.iconsBTC,
                    name: "Bitcoin",
                    symbol: "BTC",
                    value: "\$1,270.10",
                    change: "+2.76%",
                    isPositive: true,
                  ),
                  Divider(height: 1, indent: 70, endIndent: 16),
                  _PortfolioCoinTile(
                    iconPath: AppIconsPath.iconsETH,
                    name: "Ethereum",
                    symbol: "ETH",
                    value: "\$270.10",
                    change: "-1.25%",
                    isPositive: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          content: title,
          style: AppTextStyle.text16Medium.copyWith(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        AppText(
          content: "More",
          style: AppTextStyle.text16Medium.copyWith(color: AppColorsPath.blue)),
      ],
    );
  }
}

//  WIDGETS MarketMover

class _MarketMoverCard extends StatelessWidget {
  final String iconPath;
  final String symbol;
  final String price;
  final String change;
  final bool isPositive;
  final String volume;

  const _MarketMoverCard({
    required this.iconPath,
    required this.symbol,
    required this.price,
    required this.change,
    required this.isPositive,
    required this.volume,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColorsPath.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColorsPath.lightWhite,
                child: Image.asset(iconPath, height: 20, width: 20),
              ),
              const SizedBox(width: 8),
              AppText(
                content: symbol,
                style: AppTextStyle.text14Regular.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AppText(
            content: price,
            style: AppTextStyle.text16Medium.copyWith(color: Colors.black),
          ),
          AppText(
            content: change,
            style: AppTextStyle.text14Regular.copyWith(color: isPositive ? Colors.green : Colors.red),
          ),

          ///  Image line chart
          Image.asset(AppImagePaths.img_sharp_recovery),
          Expanded(
            child: Center(
              child: Image.asset(
                AppImagePaths.img_finance_wave,
                color: isPositive ? Colors.green.withValues(alpha: 0.5) : Colors.red.withValues(alpha: 0.5),
              ),
            ),
          ),
          AppText(
            content: "24H Vol. $volume",
            style: AppTextStyle.text14Regular.copyWith(color: AppColorsPath.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
   // WIDGETS PortfolioCoinTile
class _PortfolioCoinTile extends StatelessWidget {
  final String iconPath;
  final String name;
  final String symbol;
  final String value;
  final String change;
  final bool isPositive;

  const _PortfolioCoinTile({
    required this.iconPath,
    required this.name,
    required this.symbol,
    required this.value,
    required this.change,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColorsPath.lightWhite,
            child: Image.asset(iconPath, height: 24, width: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                content: name,
                style: AppTextStyle.text16Medium.copyWith(color: Colors.black),
              ),
              AppText(
                content: symbol,
                style: AppTextStyle.text14Regular.copyWith(color: AppColorsPath.grey),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                content: value,
                style: AppTextStyle.text16Medium.copyWith(color: Colors.black),
              ),
              AppText(
                content: change,
                style: AppTextStyle.text14Regular.copyWith(color: isPositive ? Colors.green : Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}