import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/auth/UI/sign_in.dart';

class EmailSent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/email_sent.png",
                width: pxToSp(context, 100), height: pxToSp(context, 100)),
            const SizedBox(height: 25),
            Text(
              "We Sent you an Email to reset your password.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.darkBrown,
                  fontSize: pxToSp(context, 24),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () => naviagteTo(context, SignIn()),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkBrown,
                  minimumSize: Size(pxToSp(context, 159), pxToSp(context, 52))),
              child: Text(
                "Return to Login",
                style: TextStyle(
                    fontSize: pxToSp(context, 20),
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
