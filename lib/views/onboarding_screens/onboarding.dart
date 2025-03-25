import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/functions/navigate_without_back.dart';
import 'package:furniture_app/views/auth/UI/sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                          pxToSp(context, 30),
                        )),
                        child: Image.asset(
                          onboardingData[index]["image"]!,
                          fit: BoxFit.fill,
                          width: imageWidth,
                          height: imageHeight,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: pxToSp(context, 16),
                            top: pxToSp(context, 32),
                            bottom: pxToSp(context, 14),
                            right: pxToSp(context, 40)),
                        child: Text(
                          onboardingData[index]["text"]!,
                          style: GoogleFonts.poppins(
                            height: 1.4,
                            fontSize: pxToSp(context, 24),
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkBrown,
                          ),
                        )),
                  ],
                );
              },
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: onboardingData.length,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.darkBrown,
              dotHeight: pxToSp(context, 6),
              dotWidth: pxToSp(context, 6),
              expansionFactor: 2,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: currentIndex == onboardingData.length - 1
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: AppColors.darkBrown,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(pxToSp(context, 50)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      navigateWithoutBack(context, SignIn());
                    },
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                          fontSize: pxToSp(context, 24), color: Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          _controller.jumpToPage(onboardingData.length - 1);
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                              color: Color(0xff828A89),
                              fontSize: pxToSp(context, 16)),
                        ),
                      ),
                      FloatingActionButton(
                        shape: CircleBorder(),
                        backgroundColor: AppColors.darkBrown,
                        onPressed: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                          );
                        },
                        child: const Icon(Icons.arrow_forward,
                            color: Colors.white),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
