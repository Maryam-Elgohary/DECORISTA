import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';

class product_details_reviews_text extends StatelessWidget {
  const product_details_reviews_text({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text("Reviews",
            style: TextStyle(
                color: AppColors.darkBrown,
                fontWeight: FontWeight.w600,
                fontSize: pxToSp(context, 16))),
      ),
    );
  }
}
