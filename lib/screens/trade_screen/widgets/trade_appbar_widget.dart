import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

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
        IconButton(
          /// TODO: Implement search function
          onPressed: () {},
          icon: Icon(Icons.favorite, color: Colors.amberAccent),
          color: context.theme.iconTheme.color,
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
