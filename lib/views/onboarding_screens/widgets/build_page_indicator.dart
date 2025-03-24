import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/onboarding_screens/widgets/onboarding_page_class.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Widget buildPageIndicator(BuildContext context, PageController _pageController,
    List<OnboardingPage> _onboardingPages) {
  return SmoothPageIndicator(
    controller: _pageController,
    count: _onboardingPages.length,
    effect: const ExpandingDotsEffect(
      activeDotColor: AppColors.darkBrown,
      dotHeight: 6,
      dotWidth: 6,
      expansionFactor: 2,
    ),
  );
}
