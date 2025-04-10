import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';

class AuthSuccessMessage extends StatelessWidget {
  final String imagePath;
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const AuthSuccessMessage({
    super.key,
    required this.imagePath,
    required this.message,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: pxToSp(context, 100),
            height: pxToSp(context, 100),
          ),
          const SizedBox(height: 25),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.darkBrown,
              fontSize: pxToSp(context, 24),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkBrown,
              minimumSize: Size(
                pxToSp(context, 159),
                pxToSp(context, 52),
              ),
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: pxToSp(context, 20),
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
