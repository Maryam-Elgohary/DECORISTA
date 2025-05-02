import 'package:flutter/material.dart';

/// A widget for toggling the favorite status of a product.
class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.isFav,
    required this.iconSize,
    required this.onPressed,
  });

  final bool isFav;
  final double iconSize;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          isFav ? Icons.favorite : Icons.favorite_border,
          color: isFav ? Colors.red : Colors.grey,
          size: iconSize,
        ),
      ),
    );
  }
}
