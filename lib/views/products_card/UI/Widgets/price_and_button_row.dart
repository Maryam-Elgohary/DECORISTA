import 'package:flutter/material.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/products_card/UI/Widgets/Arrow_button_products_card.dart';
import 'package:furniture_app/views/products_card/UI/Widgets/price_column_products_card.dart';
import 'package:furniture_app/views/products_card/UI/Widgets/price_hasDiscount_column.dart';
import 'package:furniture_app/views/products_card/UI/products_card.dart';

class price_and_button_row extends StatelessWidget {
  const price_and_button_row({
    super.key,
    required this.widget,
    required this.buttonSize,
    required this.iconSize,
  });

  final ProductsCard widget;
  final double buttonSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Price column
        widget.product.hasDiscount
            ? price_hasDiscount_column(widget: widget)
            : price_column_products_card(widget: widget),

        // Arrow button
        Arrow_button_products_card(
            buttonSize: buttonSize, widget: widget, iconSize: iconSize),
      ],
    );
  }
}
