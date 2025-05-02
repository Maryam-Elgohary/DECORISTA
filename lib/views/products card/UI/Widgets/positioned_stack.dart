import 'package:flutter/material.dart';
import 'package:furniture_app/views/products%20card/UI/products_card.dart';

class positioned_stack extends StatelessWidget {
  const positioned_stack({
    super.key,
    required this.widget,
    required this.iconSize,
  });

  final ProductsCard widget;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        child: Icon(
          widget.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: widget.isFavorite ? Colors.red : Colors.grey,
          size: iconSize * 0.8,
        ),
      ),
    );
  }
}
