import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/core/constants/app_icons_path.dart';
import 'package:crypto_exchange/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class OrderbookNumberWidget extends StatelessWidget {
  final String content;
  final VoidCallback? onTap;
  final double horizontalPadding;
  const OrderbookNumberWidget({
    required this.content,
    this.onTap,
    this.horizontalPadding = 14,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF2F66F6).withValues(alpha: 0.12),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: horizontalPadding),
      child: Row(
        children: [
          AppText(
            content: content,
            style: context.theme.textTheme.titleSmall!.copyWith(
              color: Colors.black,
            ),
          ),
          SizedBox(width: 4),
          InkWell(
            onTap: onTap,
            child: Image.asset(AppIconsPath.iconsBack, width: 7, height: 7),
          ),
        ],
      ),
    );
  }
}
