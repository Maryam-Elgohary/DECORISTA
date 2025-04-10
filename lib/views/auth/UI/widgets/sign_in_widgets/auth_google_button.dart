import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';

class AuthGoogleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AuthGoogleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const FaIcon(
        FontAwesomeIcons.google,
        size: 25,
        color: Colors.red,
      ),
      label: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          "Continue With Google",
          style: TextStyle(
            fontSize: pxToSp(context, 20),
            color: AppColors.darkBrown,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xfff4f4f4),
        minimumSize: const Size(double.infinity, 50),
      ),
    );
  }
}
