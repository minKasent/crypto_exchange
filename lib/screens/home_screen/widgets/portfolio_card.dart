import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/constants/app_colors_path.dart';
import 'package:flutter/material.dart';

class PortfolioCard extends StatelessWidget {
  const PortfolioCard({
    required this.iconPath,
    required this.name,
    required this.symbol,
    required this.value,
    required this.change,
    required this.isPositive,
    super.key,
  });

  final String iconPath;
  final String name;
  final String symbol;
  final String value;
  final String change;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF2F66F6).withValues(alpha: 0.5),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(iconPath, height: 40, width: 40),
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
                style: AppTextStyle.text14Regular.copyWith(
                  color: AppColorsPath.grey,
                ),
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
                style: AppTextStyle.text14Regular.copyWith(
                  color: isPositive ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
