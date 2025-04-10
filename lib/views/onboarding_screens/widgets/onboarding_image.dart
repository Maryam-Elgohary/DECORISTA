import 'package:flutter/material.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';

class onboarding_image extends StatelessWidget {
  const onboarding_image(
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
    return Expanded(
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
    );
  }
}
