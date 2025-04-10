import 'package:flutter/material.dart';
import 'package:furniture_app/views/onboarding_screens/widgets/onboarding_get_started_button.dart';
import 'package:furniture_app/views/onboarding_screens/widgets/onboarding_skip_button.dart';

class onboarding_skip_next_button extends StatelessWidget {
  const onboarding_skip_next_button({
    super.key,
    required this.currentIndex,
    required this.onboardingData,
    required PageController controller,
  }) : _controller = controller;

  final int currentIndex;
  final List<Map<String, String>> onboardingData;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: currentIndex == onboardingData.length - 1
          ? onboarding_get_started_button()
          : onboarding_skip_button(
              controller: _controller, onboardingData: onboardingData),
    );
  }
}
