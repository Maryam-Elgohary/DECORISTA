import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/components/navigate_to.dart';
import 'package:furniture_app/views/categories/UI/categories_screen.dart';

class home_categories_see_all extends StatelessWidget {
  const home_categories_see_all({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Categories",
          style: TextStyle(
            color: AppColors.darkBrown,
            fontSize: pxToSp(context, 20),
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
          onPressed: () {
            naviagteTo(context, CategoriesScreen());
          },
          child: Text(
            "See All",
            style: TextStyle(
              color: AppColors.darkBrown,
              fontSize: pxToSp(context, 16),
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
