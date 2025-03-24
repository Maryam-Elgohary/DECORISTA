import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildPaymentButton(void handlePayment()) {
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
      onPressed: handlePayment,
      child: Text(
        "Payment",
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
