import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/constants/app_colors_path.dart';
import 'package:crypto_exchange/core/extensions/context_extension.dart';
import 'package:crypto_exchange/providers/home_provider.dart';
import 'package:crypto_exchange/providers/trade_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderBookWidget extends StatelessWidget {
  const OrderBookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TradeProvider>(builder: (context, tradeProvider, child) {
      if (tradeProvider.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (tradeProvider.orderBook == null) {
        return const Center(child: AppText(content: "Loading Order Book..."));
      }

      final orderBook = tradeProvider.orderBook!;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                content: 'Price',
                style: AppTextStyle.text14Regular
                    .copyWith(color: AppColorsPath.grey)),
              AppText(
                content: 'Amount',
                style: AppTextStyle.text14Regular
                    .copyWith(color: AppColorsPath.grey)),
            ],
          ),
          const SizedBox(height: 8),

          // List Sell color red
          ListView.builder(
            itemCount: orderBook.asks.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final ask = orderBook.asks.reversed.toList()[index];
              return _buildOrderBookRow(
                  ask[0].toString(), ask[1].toString(), AppColorsPath.red);
            },
          ),
          const SizedBox(height: 8),

          // price and change percent
          Consumer<HomeProvider>(builder: (context, homeProvider, child) {
            final price = homeProvider.listOfCoins.isNotEmpty
                ? double.parse(homeProvider.listOfCoins.first.price)
                .toStringAsFixed(2)
                : "0.00";
            final isPositive = homeProvider.listOfCoins.isNotEmpty
                ? double.parse(
                homeProvider.listOfCoins.first.priceChangePercent) >
                0
                : true;
            return AppText(
              content: price,
              style: AppTextStyle.text16Medium.copyWith(
                color: isPositive ? AppColorsPath.green : AppColorsPath.red,
              ),
            );
          }),
          const SizedBox(height: 8),

          // List Buy color green
          ListView.builder(
            itemCount: orderBook.bids.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final bid = orderBook.bids[index];
              return _buildOrderBookRow(
                  bid[0].toString(), bid[1].toString(), AppColorsPath.green);
            },
          ),
        ],
      );
    });
  }

  Widget _buildOrderBookRow(String price, String amount, Color color) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              content: double.parse(price).toStringAsFixed(2),
              style: AppTextStyle.text14Regular.copyWith(color: color)),
            AppText(
              content: double.parse(amount).toStringAsFixed(4),
              style: AppTextStyle.text14Regular
                  .copyWith(color: context.titleSmallColor)),
          ],
        ),
      );
    });
  }
}