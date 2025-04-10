import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/products_details/UI/product_details.dart';
import 'package:google_fonts/google_fonts.dart';

class product_details_total_price extends StatelessWidget {
  const product_details_total_price({
    super.key,
    required this.widget,
    required this.quantity,
  });

  final ProductDetails widget;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Text(
      "\$${(widget.product.discountedPrice * quantity).toStringAsFixed(2)}",
      style: GoogleFonts.poppins(
          color: AppColors.darkBrown,
          fontSize: 20,
          fontWeight: FontWeight.w500),
    );
  }
}
