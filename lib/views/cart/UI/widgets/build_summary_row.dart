import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildSummaryRow(String label, double value, {bool isTotal = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: isTotal ? 18 : 16,
          fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
          color: isTotal ? AppColors.darkBrown : const Color(0xff828A89),
        ),
      ),
      Text(
        '\$${value.toStringAsFixed(2)}',
        style: GoogleFonts.poppins(
          fontSize: isTotal ? 18 : 16,
          fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
          color: AppColors.orangeColor,
        ),
      ),
    ],
  );
}
