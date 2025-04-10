import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:google_fonts/google_fonts.dart';

class onboarding_text extends StatelessWidget {
  const onboarding_text(
      {super.key, required this.onboardingData, required this.index});

  final List<Map<String, String>> onboardingData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
        ));
  }
}
