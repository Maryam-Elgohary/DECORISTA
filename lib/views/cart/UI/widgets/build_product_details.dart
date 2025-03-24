import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildProductDetails(Products item) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        item.productName,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.darkBrown,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      Text(
        item.brand ?? '',
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      const SizedBox(height: 4),
      Text(
        _calculateItemPrice(item),
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: AppColors.orangeColor,
        ),
      ),
    ],
  );
}

String _calculateItemPrice(Products item) {
  final price = item.specialOffersTable.isNotEmpty
      ? (item.price * ((100 - item.specialOffersTable.first.discount) / 100)) *
          (item.quantity ?? 1)
      : item.price * (item.quantity ?? 1);
  return '\$${price.toStringAsFixed(2)}';
}
