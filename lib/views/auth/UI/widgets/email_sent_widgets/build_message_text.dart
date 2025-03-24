import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

Widget buildMessageText(BuildContext context) {
  return Text(
    "We sent you an email to reset your password.",
    textAlign: TextAlign.center,
    style: TextStyle(
      color: AppColors.darkBrown,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
  );
}
