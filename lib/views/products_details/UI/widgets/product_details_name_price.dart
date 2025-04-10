import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/products_details/UI/product_details.dart';
import 'package:google_fonts/google_fonts.dart';

class product_details_name_price extends StatelessWidget {
  const product_details_name_price({
    super.key,
    required this.widget,
  });

  final ProductDetails widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Text(
            "${widget.product.productName}",
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
        widget.product.hasDiscount
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$${widget.product.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.lineThrough,
                      color: AppColors.lightBrown,
                    ),
                  ),
                  Text(
                    "\$${widget.product.discountedPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.orangeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : Text(
                "\$${widget.product.price.toStringAsFixed(2)}",
                style: TextStyle(
                  color: AppColors.orangeColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
      ],
    );
  }
}
