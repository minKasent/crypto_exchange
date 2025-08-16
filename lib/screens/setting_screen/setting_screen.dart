import 'package:crypto_exchange/components/app_button.dart';
import 'package:crypto_exchange/core/constants/app_icons_path.dart';
import 'package:crypto_exchange/core/enum/enum.dart';
import 'package:crypto_exchange/core/extensions/context_extension.dart';
import 'package:crypto_exchange/models/setting_category_item_model.dart';
import 'package:crypto_exchange/screens/setting_screen/widgets/setting_appbar_widget.dart';
import 'package:crypto_exchange/screens/setting_screen/widgets/setting_category_items_widget.dart';
import 'package:crypto_exchange/screens/setting_screen/widgets/setting_user_info_widget.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  static final List<SettingCategoryItemModel> settingPrivacyItems = [
    SettingCategoryItemModel(
      iconPath: AppIconsPath.iconsProfile,
      onTap: (context) {},
      title: 'Profile',
    ),
    SettingCategoryItemModel(
      iconPath: AppIconsPath.iconsSecurity,
      onTap: (context) {},
      title: 'Security',
    ),
  ];

  static final List<SettingCategoryItemModel> settingFinanceItems = [
    SettingCategoryItemModel(
      iconPath: AppIconsPath.iconsHistory,
      onTap: (context) {},
      title: 'History',
    ),
    SettingCategoryItemModel(
      iconPath: AppIconsPath.iconsLimit,
      onTap: (context) {},
      title: 'Limits',
    ),
  ];

  static final List<SettingCategoryItemModel> settingAccountItems = [
    SettingCategoryItemModel(
      iconPath: AppIconsPath.iconsTheme,
      onTap: (context) {},
      title: 'Theme',
      isDarkMode: true,
    ),
    SettingCategoryItemModel(
      iconPath: AppIconsPath.iconsNotification,
      onTap: (context) {},
      title: 'Notifications',
    ),
  ];

  static final List<SettingCategoryItemModel> settingMoreItems = [
    SettingCategoryItemModel(
      iconPath: AppIconsPath.iconsMyBonus,
      onTap: (context) {},
      title: 'My bonus',
    ),
    SettingCategoryItemModel(
      iconPath: AppIconsPath.iconsShareWithFriend,
      onTap: (context) {},
      title: 'Share with friends',
    ),
    SettingCategoryItemModel(
      iconPath: AppIconsPath.iconsSupport,
      onTap: (context) {},
      title: 'Support',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: SettingAppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SettingUserInfoWidget(),
              const SizedBox(height: 15),

              SettingCategoryItemsWidget(
                categoryTitle: "Privacy",
                categoryItems: settingPrivacyItems,
              ),
              const SizedBox(height: 15),

              SettingCategoryItemsWidget(
                categoryTitle: "Finance",
                categoryItems: settingFinanceItems,
              ),
              const SizedBox(height: 15),

              SettingCategoryItemsWidget(
                categoryTitle: "Account",
                categoryItems: settingAccountItems,
              ),
              const SizedBox(height: 15),

              SettingCategoryItemsWidget(
                categoryTitle: "More",
                categoryItems: settingMoreItems,
              ),
              SizedBox(height: 24),
              AppButton(
                title: "Log Out",
                buttonState: ButtonState.second,
                onTap: () {},
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
