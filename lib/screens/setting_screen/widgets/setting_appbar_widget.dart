import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/constants/app_colors_path.dart';
import 'package:crypto_exchange/core/constants/app_icons_path.dart';
import 'package:crypto_exchange/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class SettingAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const SettingAppbarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Standard AppBar height

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.theme.appBarTheme.backgroundColor,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Image.asset(AppIconsPath.iconsBack),
      ),
      centerTitle: true,
      title: AppText(
        content: "Setting",
        style: AppTextStyle.text16Medium.copyWith(
          fontSize: 18,
          color: AppColorsPath.darkBlue,
        ),
      ),
      actions: [
        IconButton(
          /// TODO: Implement search function
          onPressed: () {},
          icon: Image.asset(AppIconsPath.iconsSearch),
        ),
      ],
    );
  }
}
