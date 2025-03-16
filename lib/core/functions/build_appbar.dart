import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

AppBar buildCustomAppBar(BuildContext context, String title) {
  return AppBar(
    centerTitle: true,
    title: Text(title, style: const TextStyle(color: AppColors.darkBrown)),
    backgroundColor: Colors.transparent,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.darkBrown,
        )),
  );
}
