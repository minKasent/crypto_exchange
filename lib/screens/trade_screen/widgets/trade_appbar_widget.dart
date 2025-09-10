import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/extensions/context_extension.dart';
import 'package:crypto_exchange/providers/favorite_provider.dart';
import 'package:crypto_exchange/providers/trade_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TradeAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const TradeAppbarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Standard AppBar height

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.appBarTheme.backgroundColor,
      // leading: IconButton(
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      //   icon: Image.asset(AppIconsPath.iconsBack),
      //   color: context.theme.iconTheme.color,
      // ),
      centerTitle: true,
      title: AppText(
        content: "Trade",
        style: AppTextStyle.text16Medium.copyWith(
          fontSize: 18,
          color: context.theme.textTheme.titleSmall!.color,
        ),
      ),
      actions: [
        Consumer<TradeProvider>(
          builder: (_, tradeProvider, __) {
            return IconButton(
              onPressed: () {
                context.read<FavoriteProvider>().toggleFavoriteToken(
                  tradeProvider.currentSymbol,
                );
              },
              icon: Icon(
                tradeProvider.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: tradeProvider.isFavorite ? Colors.yellow : Colors.black,
              ),
              color: context.theme.iconTheme.color,
            );
          },
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
