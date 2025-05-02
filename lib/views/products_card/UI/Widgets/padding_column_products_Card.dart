import 'package:flutter/material.dart';
import 'package:furniture_app/views/products_card/UI/Widgets/AspectRatio_products_card.dart';
import 'package:furniture_app/views/products_card/UI/Widgets/price_and_button_row.dart';
import 'package:furniture_app/views/products_card/UI/Widgets/products_card_name_part.dart';
import 'package:furniture_app/views/products_card/UI/products_card.dart';

class padding_column_products_Card extends StatelessWidget {
  const padding_column_products_Card({
    super.key,
    required this.widget,
    required this.iconSize,
    required this.textSize,
    required this.buttonSize,
  });

  final ProductsCard widget;
  final double iconSize;
  final double textSize;
  final double buttonSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image section
        AspectRatio_products_card(widget: widget, iconSize: iconSize),

        const SizedBox(height: 8),

        // Product name (with fixed max lines)
        products_card_name_part(textSize: textSize, widget: widget),

        const SizedBox(height: 8),

        // Price and button row
        price_and_button_row(
            widget: widget, buttonSize: buttonSize, iconSize: iconSize),
      ],
    );
  }
}
