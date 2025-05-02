import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/products_card/UI/products_card.dart';

class price_column_products_card extends StatelessWidget {
  const price_column_products_card({
    super.key,
    required this.widget,
  });

  final ProductsCard widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "\$${widget.product.price.toStringAsFixed(2)}",
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
