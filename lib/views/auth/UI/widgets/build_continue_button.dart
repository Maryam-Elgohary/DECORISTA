import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

Widget buildContinueButton(BuildContext context, void submitForm()) {
  return ElevatedButton(
    onPressed: submitForm,
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.darkBrown,
      minimumSize: const Size(double.infinity, 50),
    ),
    child: const Text(
      "Continue",
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

