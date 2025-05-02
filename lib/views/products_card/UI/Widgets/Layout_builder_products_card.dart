
import 'package:flutter/material.dart';
import 'package:furniture_app/views/products_card/UI/Widgets/layout_builder_card.dart';
import 'package:furniture_app/views/products_card/UI/products_card.dart';

class Layout_builder_products_card extends StatelessWidget {
  const Layout_builder_products_card({
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return layout_builder_card(
          widget: widget,
          iconSize: iconSize,
          textSize: textSize,
          buttonSize: buttonSize,
          constraints: constraints,
        );
      },
    );
  }
}
