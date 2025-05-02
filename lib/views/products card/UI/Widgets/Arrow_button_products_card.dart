import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/products%20card/UI/products_card.dart';
import 'package:furniture_app/views/products_details/UI/product_details.dart';

class Arrow_button_products_card extends StatelessWidget {
  const Arrow_button_products_card({
    super.key,
    required this.buttonSize,
    required this.widget,
    required this.iconSize,
  });

  final double buttonSize;
  final ProductsCard widget;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.darkBrown),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: () {
          naviagteTo(
            context,
            ProductDetails(
              product: widget.product,
              isFav: widget.isFavorite,
            ),
          );
        },
        icon: Icon(
          Icons.arrow_forward_rounded,
          size: iconSize,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
