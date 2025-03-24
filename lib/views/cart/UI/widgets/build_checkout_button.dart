import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/cart/UI/widgets/navigate_to_checkout.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildCheckoutButton(
    double subtotal, BuildContext context, double shippingCost) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkBrown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () => navigateToCheckout(subtotal, context, shippingCost),
      child: Text(
        "Check Out",
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
