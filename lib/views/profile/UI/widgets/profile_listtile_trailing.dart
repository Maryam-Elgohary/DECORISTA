import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

class profile_listtile_trailing extends StatelessWidget {
  const profile_listtile_trailing({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_forward_ios_outlined,
      color: AppColors.darkBrown,
    );
  }
}
