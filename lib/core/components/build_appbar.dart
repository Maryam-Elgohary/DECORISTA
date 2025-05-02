import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

AppBar buildCustomAppBar(BuildContext context, String title) {
  return AppBar(
    centerTitle: true,
    title: Text(title,
        style:
            TextStyle(color: AppColors.darkBrown, fontWeight: FontWeight.w500)),
    backgroundColor: Colors.transparent,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.darkBrown,
        )),
  );
}
