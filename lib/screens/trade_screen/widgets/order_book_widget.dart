import 'package:crypto_exchange/components/app_button.dart';
import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/constants/app_colors_path.dart';
import 'package:crypto_exchange/core/enum/enum.dart';
import 'package:crypto_exchange/models/order_book_model.dart';
import 'package:crypto_exchange/providers/trade_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderBookWidget extends StatelessWidget {
  const OrderBookWidget({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<TradeProvider>(
      builder: (context, tradeProvider, child) {
        if (tradeProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (tradeProvider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(content: "Error: ${tradeProvider.error}"),
                const SizedBox(height: 8),
                AppButton(
                  title: "Retry",
                  buttonState: ButtonState.normal,
                  onTap: () => tradeProvider.connectToOrderBookStream(
                    tradeProvider.currentSymbol,
                  ),
                  backgroundColor: AppColorsPath.lightWhite,
                ),
              ],
            ),
          );
        }

        if (tradeProvider.bids.isEmpty && tradeProvider.asks.isEmpty) {
          return const Center(child: AppText(content: "No Order Book Data"));
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildOrderBookSection(
                      tradeProvider.asks.reversed.toList(),
                      AppColorsPath.red,
                    ),
                    const SizedBox(height: 8),
                    _buildOrderBookSection(
                      tradeProvider.bids,
                      AppColorsPath.green,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText(
          content: 'Price',
          style: AppTextStyle.text14Regular.copyWith(color: AppColorsPath.grey),
        ),
        AppText(
          content: 'Amount',
          style: AppTextStyle.text14Regular.copyWith(color: AppColorsPath.grey),
        ),
      ],
    );
  }

  Widget _buildOrderBookSection(List<OrderBookEntry> orders, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...orders.take(10).map((order) => _buildOrderBookRow(order, color)),
      ],
    );
  }

  Widget _buildOrderBookRow(OrderBookEntry order, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            content: double.parse(order.price).toStringAsFixed(2),
            style: AppTextStyle.text14Regular.copyWith(color: color),
          ),
          AppText(
            content: double.parse(order.quantity).toStringAsFixed(4),
            style: AppTextStyle.text14Regular.copyWith(
              color: AppColorsPath.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSpread(TradeProvider provider) {
    if (provider.asks.isEmpty || provider.bids.isEmpty) return const SizedBox();

    final highestBid = double.parse(provider.bids.first.price);
    final lowestAsk = double.parse(provider.asks.first.price);
    final spread = lowestAsk - highestBid;
    final spreadPercent = (spread / lowestAsk) * 100;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColorsPath.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            content: "Spread",
            style: AppTextStyle.text14Regular.copyWith(
              fontSize: 12,
              color: AppColorsPath.grey,
            ),
          ),
          AppText(
            content:
                "${spread.toStringAsFixed(2)} (${spreadPercent.toStringAsFixed(2)}%)",
            style: AppTextStyle.text14Regular.copyWith(
              fontSize: 12,
              color: AppColorsPath.grey,
            ),
          ),
        ],
      ),
    );
  }
}
