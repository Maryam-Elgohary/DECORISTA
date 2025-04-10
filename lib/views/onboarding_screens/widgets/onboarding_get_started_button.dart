import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/functions/navigate_without_back.dart';
import 'package:furniture_app/views/auth/UI/sign_in.dart';

class onboarding_get_started_button extends StatelessWidget {
  const onboarding_get_started_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: AppColors.darkBrown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(pxToSp(context, 50)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onPressed: () {
        navigateWithoutBack(context, SignIn());
      },
      child: Text(
        "Get Started",
        style: TextStyle(fontSize: pxToSp(context, 24), color: Colors.white),
      ),
    );
  }
}
