import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/auth/UI/forget_password.dart';

Widget buildForgotPasswordButton(BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () => naviagteTo(context, const ForgetPassword()),
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: "Forgot password?",
              style: TextStyle(
                color: AppColors.darkBrown,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: " Reset",
              style: TextStyle(
                color: AppColors.darkBrown,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
