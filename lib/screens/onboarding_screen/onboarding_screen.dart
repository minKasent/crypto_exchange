import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/components/app_text_style.dart';
import 'package:crypto_exchange/screens/home_screen/home_screen.dart';
import 'package:crypto_exchange/screens/onboarding_screen/widgets/onboarding_body_widget.dart';
import 'package:crypto_exchange/core/constants/app_colors_path.dart';
import 'package:crypto_exchange/core/constants/app_images_path.dart';
import 'package:crypto_exchange/core/extensions/context_extension.dart';
import 'package:crypto_exchange/services/storage_service.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        if (_pageController.page != null) {
          _currentPage = _pageController.page!.round();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPath.lightWhite,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset(AppImagePaths.logo)],
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: const [
                  OnboardingBodyWidget(
                    imagePath: 'assets/images/market_analysis.png',
                    title: 'Take hold of your finances',
                    description:
                        'Lorem ipsum dolor sit amet, consectetur \n adipiscing elit. Ut eget mauris massa pharetra.',
                  ),
                  OnboardingBodyWidget(
                    imagePath: 'assets/images/mobile _financial_analytics.png',
                    title: 'Smart trading tools',
                    description:
                        'Lorem ipsum dolor sit amet, consectetur \n adipiscing elit. Ut eget mauris massa pharetra.',
                  ),
                  OnboardingBodyWidget(
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
                    color:
                        _currentPage == index
                            ? AppColorsPath.blue
                            : AppColorsPath.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),

            /// TODO: Implement App Button component
            GestureDetector(
              onTap: () async {
                if (_currentPage < 2) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                } else {
                  await StorageService.instance.setOnboardingCompleted(true);
                  if (context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }
                }
              },
              child: Container(
                width: context.screenWidth - 16 * 2,
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
