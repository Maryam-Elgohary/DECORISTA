import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';

class home_special_offers_text extends StatelessWidget {
  const home_special_offers_text({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text("Special Offers",
        style: TextStyle(
            color: AppColors.darkBrown,
            fontWeight: FontWeight.w600,
            fontSize: pxToSp(context, 16)));
  }
}
