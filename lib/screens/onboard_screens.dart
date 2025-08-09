import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/components/onboarding_page.dart';
import 'package:crypto_exchange/constants/app_colors_path.dart';
import 'package:crypto_exchange/constants/app_images_path.dart';
import 'package:crypto_exchange/screens/demo_stream.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnboardScreens extends StatefulWidget {
  const OnboardScreens({super.key});

  @override
  State<OnboardScreens> createState() => _OnboardScreensState();
}

class _OnboardScreensState extends State<OnboardScreens> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColorsPath.lightWhite,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImagePaths.logo)
              ],
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: const [
                  OnboardingPage(
                    imagePath: 'assets/images/market_analysis.png',
                    title: 'Take hold of your finances',
                    description:
                    'Lorem ipsum dolor sit amet, consectetur \n adipiscing elit. Ut eget mauris massa pharetra.',
                  ),
                  OnboardingPage(
                    imagePath: 'assets/images/mobile _financial_analytics.png',
                    title: 'Smart trading tools',
                    description:
                    'Lorem ipsum dolor sit amet, consectetur \n adipiscing elit. Ut eget mauris massa pharetra.',
                  ),
                  OnboardingPage(
                    imagePath: 'assets/images/blockchain_development.png',
                    title: 'Invest in the future',
                    description:
                    'Lorem ipsum dolor sit amet, consectetur \n adipiscing elit. Ut eget mauris massa pharetra.',
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 5,
                  width: _currentPage == index ? 30 : 10,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppColorsPath.blue
                        : AppColorsPath.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () async {
                if (_currentPage < 2) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                } else {
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  await prefs.setBool('onboarding_completed', true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DemoHomeScreen()),
                  );
                }
              },
              child: Container(
                width: size.width - 16 * 2,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: AppColorsPath.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AppText(
                  content: "Next",
                  style: AppTextStyle.text16Medium,
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}