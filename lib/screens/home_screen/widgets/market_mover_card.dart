import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/constants/app_colors_path.dart';
import 'package:crypto_exchange/core/constants/app_images_path.dart';
import 'package:crypto_exchange/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class MarketMoverCard extends StatelessWidget {
  final String iconPath;
  final String symbol;
  final String price;
  final String change;
  final bool isPositive;
  final String volume;
  final bool chartPath;

  const MarketMoverCard({
    required this.iconPath,
    required this.symbol,
    required this.price,
    required this.change,
    required this.isPositive,
    required this.volume,
    required this.chartPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (156 / 375) * context.screenWidth,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  AppText(
                    content: symbol,
                    style: AppTextStyle.text14Regular.copyWith(
                      color: context.theme.textTheme.titleSmall!.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppText(
                    content: price,
                    style: AppTextStyle.text16Medium.copyWith(
                      color: context.theme.textTheme.titleSmall!.color,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Image.asset(iconPath, height: 40, width: 40),
            ],
          ),
          AppText(
            content: change,
            style: AppTextStyle.text14Regular.copyWith(
              color: isPositive ? context.theme.textTheme.titleMedium!.color : AppColorsPath.red,
            ),
          ),
          Center(
            child: Image.asset(
              chartPath
                  ? AppImagePaths.imgSharpRecovery
                  : AppImagePaths.imgSteadyGrowth,
            ),
          ),
          AppText(
            content: "24H Vol.",
            style: AppTextStyle.text14Regular.copyWith(
              color: context.theme.textTheme.titleLarge!.color,
              fontSize: 12,
            ),
          ),
          AppText(
            content: volume,
            style: AppTextStyle.text14Regular.copyWith(
              color: context.theme.textTheme.titleLarge!.color,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
