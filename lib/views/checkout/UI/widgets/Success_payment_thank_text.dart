import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';

class Success_payment_thank_text extends StatelessWidget {
  const Success_payment_thank_text({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Thank you for your order",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: AppColors.darkBrown,
          fontSize: pxToSp(context, 26),
          fontWeight: FontWeight.w500),
    );
  }
}
