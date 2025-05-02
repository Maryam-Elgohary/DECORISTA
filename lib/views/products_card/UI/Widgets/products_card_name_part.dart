import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/products_card/UI/products_card.dart';

class products_card_name_part extends StatelessWidget {
  const products_card_name_part({
    super.key,
    required this.textSize,
    required this.widget,
  });

  final double textSize;
  final ProductsCard widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: textSize * 2.4, // Enough for 2 lines of text
      child: Text(
        widget.product.productName,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: textSize,
          color: AppColors.darkBrown,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
