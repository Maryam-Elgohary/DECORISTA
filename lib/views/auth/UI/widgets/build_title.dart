import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

Widget buildTitle(BuildContext context, String title) {
  return Text(
    title,
    style: TextStyle(
      color: AppColors.darkBrown,
      fontSize: 32,
      fontWeight: FontWeight.w700,
    ),
  );
}
