import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/constants/app_colors_path.dart';
import 'package:crypto_exchange/core/constants/app_icons_path.dart';
import 'package:crypto_exchange/core/constants/app_images_path.dart';
import 'package:crypto_exchange/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingUserInfoWidget extends StatelessWidget {
  const SettingUserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String userId = "28954761";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      width: context.screenWidth,
      decoration: BoxDecoration(
        color: AppColorsPath.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColorsPath.blue.withValues(alpha: 0.12),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    CircleAvatar(child: Image.asset(AppImagePaths.imgAvartar)),
                    const SizedBox(width: 10),
                    AppText(
                      content: "Dmutro \nto***@***.com",
                      textAlign: TextAlign.start,
                      style: AppTextStyle.text14Regular.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    AppText(
                      content: "ID $userId",
                      style: AppTextStyle.text14Regular,
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: userId));
                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Copied to clipboard!'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Image.asset(AppIconsPath.iconsCopy),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Verify
          Container(
            width: 94,
            height: 36,
            decoration: BoxDecoration(
              color: AppColorsPath.lightGreen,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppIconsPath.iconsCheckVerify),
                const SizedBox(width: 5),
                AppText(content: "Verify", style: AppTextStyle.text14Regular),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
