import 'package:flutter/material.dart';
import 'package:furniture_app/views/onboarding_screens/widgets/onboarding_image_text.dart';
import 'package:furniture_app/views/onboarding_screens/widgets/onboarding_skip_next_button.dart';
import 'package:furniture_app/views/onboarding_screens/widgets/onboarding_smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _controller = PageController();
  int currentIndex = 0; //track current page index
  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/onboarding_1.png",
      "text": "Discover a World of Elegant Furniture That Match Your Style."
    },
    {
      "image": "assets/onboarding_2.png",
      "text":
          "Unique Designs, Cozy Vibes, and Top-Quality Furniture Made For You."
    },
    {
      "image": "assets/onboarding_3.png",
      "text": "Begin Your Journey Today and Redefine Your Living Space."
    }
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double imageWidth = screenWidth; // Full screen width
    double imageHeight = screenHeight * 0.6945; // 69.45% of screen height

    return Scaffold(
      body: onboarding_body(imageWidth, imageHeight),
    );
  }

  Column onboarding_body(double imageWidth, double imageHeight) {
    return Column(
      children: [
        onboarding_pageview(imageWidth, imageHeight),
        onboarding_smooth_page_indicator(
            controller: _controller, onboardingData: onboardingData),
        const SizedBox(height: 20),
        onboarding_skip_next_button(
            currentIndex: currentIndex,
            onboardingData: onboardingData,
            controller: _controller),
        const SizedBox(height: 5),
      ],
    );
  }

  Expanded onboarding_pageview(double imageWidth, double imageHeight) {
    return Expanded(
      child: PageView.builder(
        controller: _controller,
        itemCount: onboardingData.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return onboarding_image_text(
            onboardingData: onboardingData,
            imageWidth: imageWidth,
            imageHeight: imageHeight,
            index: index,
          );
        },
      ),
    );
  }
}
