import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/navigate_without_back.dart';
import 'package:furniture_app/views/auth/UI/sign_in.dart';

Widget buildGetStartedButton(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 50),
      backgroundColor: AppColors.darkBrown,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14),
    ),
    onPressed: () => navigateWithoutBack(context, const SignIn()),
    child: const Text(
      "Get Started",
      style: TextStyle(fontSize: 24, color: Colors.white),
    ),
  );
}
