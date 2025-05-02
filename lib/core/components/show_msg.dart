import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showMsg(
    BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: AppColors.darkBrown,
  ));
}
