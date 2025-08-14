import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/constants/app_colors_path.dart';
import 'package:crypto_exchange/core/constants/app_icons_path.dart';
import 'package:crypto_exchange/core/constants/app_images_path.dart';
import 'package:crypto_exchange/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPath.green,
      appBar: AppBar(
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
            onPressed: () {},
            icon: Image.asset(AppIconsPath.iconsSearch),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              width: context.screenWidth,
              decoration: BoxDecoration(
                color: AppColorsPath.white,
                borderRadius: BorderRadius.circular(14),
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
                            // Avartar
                            CircleAvatar(
                              child: Image.asset(AppImagePaths.imgAvartar),
                            ),
                            SizedBox(width: 10),
                            AppText(
                              content: "Dmutro \n to***@***.com",
                              style: AppTextStyle.text14Regular.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            AppText(
                              content: "ID 28954761",
                              style: AppTextStyle.text14Regular,
                            ),
                            SizedBox(width: 8),
                            Image.asset(AppIconsPath.iconsCopy),
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
                        SizedBox(width: 5),
                        AppText(
                          content: "Verify",
                          style: AppTextStyle.text14Regular,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerLeft,
              child: AppText(content: "Privacy", style: AppTextStyle.text14Regular),
            ),
            SizedBox(height: 7,),
            Container(
              decoration: BoxDecoration(
                color: AppColorsPath.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
              ),
              padding: EdgeInsets.symmetric(vertical: 16,horizontal: 14),
              width: context.screenWidth,
              child: Row(
                children: [
                  Image.asset(AppIconsPath.iconsProfile, height: 24, width: 24),
                  SizedBox(width: 8),
                  AppText(
                    content: "Profile",
                    style: AppTextStyle.text14Regular.copyWith(
                      fontSize: 16,
                      color: AppColorsPath.darkBlue,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, color: AppColorsPath.grey),
                ],
              ),

            ),
          ],
        ),
      ),
    );



  }
  Container _buildItemWidgets(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorsPath.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
      ),
      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 14),
      width: context.screenWidth,
      child: Row(
        children: [
          Image.asset(AppIconsPath.iconsProfile, height: 24, width: 24),
          SizedBox(width: 8),
          AppText(
            content: "Profile",
            style: AppTextStyle.text14Regular.copyWith(
              fontSize: 16,
              color: AppColorsPath.darkBlue,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, color: AppColorsPath.grey),
        ],
      ),

    );
}
