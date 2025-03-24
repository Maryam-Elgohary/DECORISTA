import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/auth/UI/sign_in.dart';

Widget buildReturnButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () => naviagteTo(context, const SignIn()),
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.darkBrown,
      minimumSize: const Size(159, 52),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    child: const Text(
      "Return to Login",
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
