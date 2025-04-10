import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

class success_payment_circle_avatar extends StatelessWidget {
  const success_payment_circle_avatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
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
