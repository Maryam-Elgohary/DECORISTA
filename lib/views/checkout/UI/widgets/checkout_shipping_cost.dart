import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/checkout/UI/check_out.dart';
import 'package:google_fonts/google_fonts.dart';

class checkout_shipping_cost extends StatelessWidget {
  const checkout_shipping_cost({
    super.key,
    required this.widget,
  });

  final CheckOut widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Shipping Cost",
          style: GoogleFonts.poppins(fontSize: 16, color: Color(0xff828A89)),
        ),
        Text(
          "\$${widget.shippingCost}",
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: AppColors.orangeColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
