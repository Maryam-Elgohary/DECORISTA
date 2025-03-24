import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

class SuccessIcon extends StatelessWidget {
  const SuccessIcon();

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundColor: AppColors.darkBrown,
      radius: 50,
      child: Icon(
        Icons.check,
        color: Colors.white,
        size: 50,
      ),
    );
  }
}
