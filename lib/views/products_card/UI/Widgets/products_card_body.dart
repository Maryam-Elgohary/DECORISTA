
import 'package:flutter/material.dart';
import 'package:furniture_app/views/products_card/UI/Widgets/padding_column_products_Card.dart';
import 'package:furniture_app/views/products_card/UI/products_card.dart';

class products_card_body extends StatelessWidget {
  const products_card_body({
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: padding_column_products_Card(
          widget: widget,
          iconSize: iconSize,
          textSize: textSize,
          buttonSize: buttonSize),
    );
  }
}
