import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';

class AuthFooter extends StatelessWidget {
  final String questionText;
  final String actionText;
  final VoidCallback onPressed;

  const AuthFooter({
    super.key,
    required this.questionText,
    required this.actionText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: questionText,
            style: TextStyle(
              color: AppColors.darkBrown,
              fontSize: pxToSp(context, 16),
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: actionText,
            style: TextStyle(
              color: AppColors.darkBrown,
              fontSize: pxToSp(context, 16),
              fontWeight: FontWeight.w700,
            ),
          ),
        ]),
      ),
    );
  }
}
