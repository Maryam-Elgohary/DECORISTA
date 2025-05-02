import 'package:flutter/material.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/products_card/UI/Widgets/Layout_builder_products_card.dart';

class ProductsCard extends StatefulWidget {
  const ProductsCard({
    super.key,
    required this.product,
    this.onTap,
    required this.isFavorite,
    this.discount = 0,
  });

  final Products product;
  final Function()? onTap;
  final bool isFavorite;
  final int discount;

  @override
  _ProductsCardState createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth * 0.4; // Consistent image height
    final textSize = screenWidth * 0.045;
    final iconSize = screenWidth * 0.06;
    final buttonSize = screenWidth * 0.1;

    return Layout_builder_products_card(
        widget: widget,
        iconSize: iconSize,
        textSize: textSize,
        buttonSize: buttonSize);
  }
}
