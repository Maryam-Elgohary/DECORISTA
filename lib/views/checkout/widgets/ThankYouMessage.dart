import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

class ThankYouMessage extends StatelessWidget {
  const ThankYouMessage();

  @override
  Widget build(BuildContext context) {
    return Text(
      "Thank you for your order",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.darkBrown,
        fontSize: 26,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
