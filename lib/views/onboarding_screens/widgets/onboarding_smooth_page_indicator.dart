import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onboarding_smooth_page_indicator extends StatelessWidget {
  const onboarding_smooth_page_indicator({
    super.key,
    required PageController controller,
    required this.onboardingData,
  }) : _controller = controller;

  final PageController _controller;
  final List<Map<String, String>> onboardingData;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: _controller,
      count: onboardingData.length,
      effect: ExpandingDotsEffect(
        activeDotColor: AppColors.darkBrown,
        dotHeight: pxToSp(context, 6),
        dotWidth: pxToSp(context, 6),
        expansionFactor: 2,
      ),
    );
  }
}
