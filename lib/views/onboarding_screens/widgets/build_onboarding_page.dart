import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/onboarding_screens/widgets/onboarding_page_class.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildOnboardingPage(BuildContext context, OnboardingPage page) {
  final size = MediaQuery.of(context).size;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
          ),
          child: Image.asset(
            page.imagePath,
            fit: BoxFit.fill,
            width: size.width,
            height: size.height * 0.6945,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 40, 14),
        child: Text(
          page.text,
          style: GoogleFonts.poppins(
            height: 1.4,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: AppColors.darkBrown,
          ),
        ),
      ),
    ],
  );
}
