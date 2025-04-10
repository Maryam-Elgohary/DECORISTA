import 'package:flutter/material.dart';
import 'package:furniture_app/views/onboarding_screens/widgets/onboarding_image.dart';
import 'package:furniture_app/views/onboarding_screens/widgets/onboarding_text.dart';

class onboarding_image_text extends StatelessWidget {
  const onboarding_image_text(
      {super.key,
      required this.onboardingData,
      required this.imageWidth,
      required this.imageHeight,
      required this.index});

  final List<Map<String, String>> onboardingData;
  final double imageWidth;
  final double imageHeight;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        onboarding_image(
          onboardingData: onboardingData,
          imageWidth: imageWidth,
          imageHeight: imageHeight,
          index: index,
        ),
        onboarding_text(onboardingData: onboardingData, index: index),
      ],
    );
  }
}
