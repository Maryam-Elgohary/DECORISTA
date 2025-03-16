import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

class CustomCircleProIndicator extends StatelessWidget {
  const CustomCircleProIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.darkBrown,
      ),
    );
  }
}
