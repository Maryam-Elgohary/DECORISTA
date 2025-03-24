import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

class ReviewsTitleSection extends StatelessWidget {
  const ReviewsTitleSection();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Reviews',
          style: TextStyle(
            color: AppColors.darkBrown,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
