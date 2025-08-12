import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/core/constants/app_icons_path.dart';
import 'package:crypto_exchange/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class OnboardingBodyWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingBodyWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                width: context.screenWidth - 28,
                height: context.screenWidth - 28,
                child: Center(
                  child: Image.asset(imagePath, fit: BoxFit.contain),
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
              child: AppText(content: title),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                description,
                style: AppTextStyle.text14Regular,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
