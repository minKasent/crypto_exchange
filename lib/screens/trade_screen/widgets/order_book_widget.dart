import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/constants/app_colors_path.dart';
import 'package:crypto_exchange/core/extensions/context_extension.dart';
import 'package:crypto_exchange/providers/trade_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderBookWidget extends StatelessWidget {
  const OrderBookWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TradeProvider>(
      builder: (context, tradeProvider, child) {
        if (tradeProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (tradeProvider.bids.isEmpty && tradeProvider.asks.isEmpty) {
          return const Center(child: AppText(content: "No Order Book Data"));
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  content: 'Price',
                  style: AppTextStyle.text14Regular.copyWith(
                    color: AppColorsPath.grey,
                  ),
                ),
                AppText(
                  content: 'Amount',
                  style: AppTextStyle.text14Regular.copyWith(
                    color: AppColorsPath.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // List Sell color red
            ListView.builder(
              itemCount: tradeProvider.asks.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final ask = tradeProvider.asks[index];
                return _buildOrderBookRow(
                  context,
                  ask.price,
                  ask.quantity,
                  AppColorsPath.red,
                );
              },
            ),
            const SizedBox(height: 8),
            // List Buy color green
            ListView.builder(
              itemCount: tradeProvider.bids.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final bid = tradeProvider.bids[index];
                return _buildOrderBookRow(
                  context,
                  bid.price,

                  bid.quantity,
                  AppColorsPath.green,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Padding _buildOrderBookRow(
    BuildContext context,
    String price,
    String amount,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            content: double.parse(price).toStringAsFixed(2),
            style: AppTextStyle.text14Regular.copyWith(color: color),
          ),
          AppText(
            content: double.parse(amount).toStringAsFixed(4),
            style: AppTextStyle.text14Regular.copyWith(
              color: context.titleSmallColor,
            ),
          ),
        ],
      ),
    );
  }
}
