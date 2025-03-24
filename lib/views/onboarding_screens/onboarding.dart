import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/onboarding_screens/widgets/build_navigation_controls.dart';
import 'package:furniture_app/views/onboarding_screens/widgets/build_onboarding_page.dart';
import 'package:furniture_app/views/onboarding_screens/widgets/build_page_indicator.dart';
import 'package:furniture_app/views/onboarding_screens/widgets/onboarding_page_class.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  final List<OnboardingPage> _onboardingPages = const [
    OnboardingPage(
      imagePath: "assets/onboarding_1.png",
      text: "Discover a World of Elegant Furniture That Match Your Style.",
    ),
    OnboardingPage(
      imagePath: "assets/onboarding_2.png",
      text:
          "Unique Designs, Cozy Vibes, and Top-Quality Furniture Made For You.",
    ),
    OnboardingPage(
      imagePath: "assets/onboarding_3.png",
      text: "Begin Your Journey Today and Redefine Your Living Space.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _onboardingPages.length,
              onPageChanged: _handlePageChanged,
              itemBuilder: (context, index) => buildOnboardingPage(
                context,
                _onboardingPages[index],
              ),
            ),
          ),
          buildPageIndicator(context, _pageController, _onboardingPages),
          const SizedBox(height: 20),
          buildNavigationControls(
              context, _isLastPage, buildSkipAndNextButtons()),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget buildSkipAndNextButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: _skipToLastPage,
          child: const Text(
            "Skip",
            style: TextStyle(color: Color(0xff828A89), fontSize: 16),
          ),
        ),
        FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: AppColors.darkBrown,
          onPressed: _goToNextPage,
          child: const Icon(Icons.arrow_forward, color: Colors.white),
        ),
      ],
    );
  }

  bool get _isLastPage => _currentPageIndex == _onboardingPages.length - 1;

  void _handlePageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void _skipToLastPage() {
    _pageController.jumpToPage(_onboardingPages.length - 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
