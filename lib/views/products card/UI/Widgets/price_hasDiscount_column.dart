import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/products%20card/UI/products_card.dart';

class price_hasDiscount_column extends StatelessWidget {
  const price_hasDiscount_column({
    super.key,
    required this.widget,
  });

  final ProductsCard widget;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
