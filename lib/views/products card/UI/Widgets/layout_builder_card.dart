import 'package:flutter/material.dart';
import 'package:furniture_app/views/products%20card/UI/Widgets/products_card_body.dart';
import 'package:furniture_app/views/products%20card/UI/products_card.dart';

class layout_builder_card extends StatelessWidget {
  const layout_builder_card({
    super.key,
    required this.widget,
    required this.iconSize,
    required this.textSize,
    required this.buttonSize,
    required this.constraints,
  });

  final ProductsCard widget;
  final double iconSize;
  final double textSize;
  final double buttonSize;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      clipBehavior: Clip.antiAlias, // Prevents content from bleeding outside
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: constraints.maxWidth,
          maxWidth: constraints.maxWidth,
          minHeight: 0, // Let content determine height
          maxHeight: double.infinity,
        ),
        child: products_card_body(
            widget: widget,
            iconSize: iconSize,
            textSize: textSize,
            buttonSize: buttonSize),
      ),
    );
  }
}
