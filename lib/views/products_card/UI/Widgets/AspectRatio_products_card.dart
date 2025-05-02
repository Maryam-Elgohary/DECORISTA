import 'package:flutter/material.dart';
import 'package:furniture_app/views/products_card/UI/Widgets/children_stack.dart';
import 'package:furniture_app/views/products_card/UI/Widgets/positioned_stack.dart';
import 'package:furniture_app/views/products_card/UI/products_card.dart';

class AspectRatio_products_card extends StatelessWidget {
  const AspectRatio_products_card({
    super.key,
    required this.widget,
    required this.iconSize,
  });

  final ProductsCard widget;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1, // Square aspect ratio
      child: Stack(
        children: [
          children_stack(widget: widget),
          Positioned(
            top: 8,
            right: 8,
            child: positioned_stack(widget: widget, iconSize: iconSize),
          ),
        ],
      ),
    );
  }
}
