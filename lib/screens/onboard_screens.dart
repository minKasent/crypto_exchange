import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/constants/app_colors_path.dart';
import 'package:crypto_exchange/constants/app_icons_path.dart';
import 'package:crypto_exchange/constants/app_images_path.dart';
import 'package:flutter/material.dart';

class OnboardScreens extends StatelessWidget {
  const OnboardScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColorsPath.lightWhite,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  alignment: Alignment.center,
                  AppImagePaths.logo,
                  width: size.width,
                ),
              ],
            ),
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: 350,
                    height: 350,
                    child: Center(
                      child: Image.asset(
                        AppImagePaths.img_market_analysis,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // Icon Ethereum
                  Positioned(
                    top: -10,
                    left: 155,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 22,
                      child: Image.asset(AppIconsPath.iconsBTC),
                    ),
                  ),
                  // Icon Bitcoin
                  Positioned(
                    left: -10,
                    top: 100,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 22,
                      child: Image.asset(AppIconsPath.iconsETH),
                    ),
                  ),
                  // Icon Stable coin
                  Positioned(
                    right: -10,
                    top: 100,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 22,
                      child: Image.asset(AppIconsPath.iconsSLA),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 56),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: AppText(content: "Take hold of your\nfinances"),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur \n adipiscing elit. Ut eget mauris massa pharetra.",
                    style: AppTextStyle.text14Regular,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Container(
              width: size.width - 16 * 2,
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                  color: AppColorsPath.blue,
              borderRadius: BorderRadius.circular(12),
              ),
              child: AppText(
                content: "Next",
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColorsPath.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
