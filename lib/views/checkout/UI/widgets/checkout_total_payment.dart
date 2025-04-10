import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class checkout_total_payment extends StatelessWidget {
  const checkout_total_payment({
    super.key,
    required this.totalPayment,
  });

  final double totalPayment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Total Payment",
          style: GoogleFonts.poppins(
            color: AppColors.darkBrown,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          //  "\$${(widget.subtotal + widget.shippingCost).toStringAsFixed(2)}",
          "\$${totalPayment}",
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: AppColors.orangeColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
