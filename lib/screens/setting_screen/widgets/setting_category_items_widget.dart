import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/constants/app_colors_path.dart';
import 'package:crypto_exchange/core/extensions/context_extension.dart';
import 'package:crypto_exchange/models/setting_category_item_model.dart';
import 'package:crypto_exchange/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingCategoryItemsWidget extends StatelessWidget {
  final String categoryTitle;
  final List<SettingCategoryItemModel> categoryItems;

  const SettingCategoryItemsWidget({
    required this.categoryTitle,
    required this.categoryItems,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: AppText(
            content: categoryTitle,
            style: AppTextStyle.text14Regular.copyWith(
              color: context.theme.iconTheme.color,
            ),
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: context.theme.cardColor,
          ),
          padding: EdgeInsets.fromLTRB(16, 12, 0, 12),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final item = categoryItems[index];
                  return _buildCategoryItemWidget(
                    context,
                    iconPath: item.iconPath,
                    title: item.title,
                    isDarkMode: item.isDarkMode,
                    onTap: item.onTap,
                  );
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 32,
                      top: 12,
                      bottom: 12,
                    ),
                    child: Divider(color: AppColorsPath.gray2),
                  );
                },
                itemCount: categoryItems.length,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _buildCategoryItemWidget(
    BuildContext context, {
    required String iconPath,
    required String title,
    required void Function(BuildContext context) onTap,
    bool isDarkMode = false,
  }) {
    return Row(
      children: [
        Image.asset(
          iconPath,
          height: 24,
          width: 24,
          color: context.theme.iconTheme.color,
        ),
        const SizedBox(width: 8),
        AppText(
          content: title,
          style: AppTextStyle.text14Regular.copyWith(
            fontSize: 16,
            color: context.theme.textTheme.titleSmall!.color,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            onTap(context);
          },
          child: isDarkMode
              ? _buildDarkModeSwitchWidget(context)
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17 / 2),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColorsPath.grey,
                    size: 15,
                  ),
                ),
        ),
        const SizedBox(width: 12),
      ],
    );
  }
  Row _buildDarkModeSwitchWidget(BuildContext context) {
    bool isDarkMode = context.watch<ThemeProvider>().isDark;
    return Row(
      children: [
        AppText(
          content: "Dark Mode",
          style: AppTextStyle.text14Regular.copyWith(
            fontSize: 14,
            color: context.theme.iconTheme.color,
          ),
        ),
        const SizedBox(width: 12),
        StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              height: 32,
              child:  Switch(
                padding: EdgeInsets.zero,
                value: isDarkMode,
                activeColor: AppColorsPath.white,
                activeTrackColor: AppColorsPath.green,
                inactiveTrackColor: AppColorsPath.gray2,
                inactiveThumbColor: AppColorsPath.white,
                splashRadius: 0,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                thumbIcon: WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Icon(
                      Icons.circle,
                      size: 20,
                      color: AppColorsPath.white,
                    );
                  }
                  return Icon(
                    Icons.circle,
                    size: 16,
                    color: AppColorsPath.white,
                  );
                }),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                  context.read<ThemeProvider>().toggleTheme();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
