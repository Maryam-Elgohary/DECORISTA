import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

class SpecialOffersHeader extends StatelessWidget {
  const SpecialOffersHeader();

  @override
  Widget build(BuildContext context) {
    return Text(
      "Special Offers",
      style: TextStyle(
        color: AppColors.darkBrown,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }
}
