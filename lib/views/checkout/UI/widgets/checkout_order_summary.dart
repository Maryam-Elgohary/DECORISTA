import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/checkout/UI/check_out.dart';
import 'package:furniture_app/views/checkout/UI/widgets/checkout_payment_button.dart';
import 'package:furniture_app/views/checkout/UI/widgets/checkout_shipping_cost.dart';
import 'package:furniture_app/views/checkout/UI/widgets/checkout_subtotal.dart';
import 'package:furniture_app/views/checkout/UI/widgets/checkout_total_payment.dart';
import 'package:google_fonts/google_fonts.dart';

class checkout_order_summary extends StatelessWidget {
  const checkout_order_summary({
    super.key,
    required this.widget,
    required this.totalPayment,
    required this.selectedPaymentMethod,
  });

  final CheckOut widget;
  final double totalPayment;
  final int selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Summary",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.darkBrown,
          ),
        ),
        const SizedBox(height: 10),
        checkout_subtotal(widget: widget),
        const SizedBox(height: 5),
        checkout_shipping_cost(widget: widget),
        const SizedBox(height: 5),
        Divider(
          color: Color(0xfff0f0f2),
        ),
        const SizedBox(height: 5),
        checkout_total_payment(totalPayment: totalPayment),
        SizedBox(height: 5),
        checkout_payment_button(
            selectedPaymentMethod: selectedPaymentMethod,
            totalPayment: totalPayment)
      ],
    );
  }
}
