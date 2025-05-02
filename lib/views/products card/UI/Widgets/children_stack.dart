import 'package:flutter/material.dart';
import 'package:furniture_app/views/products%20card/UI/products_card.dart';

class children_stack extends StatelessWidget {
  const children_stack({
    super.key,
    required this.widget,
  });

  final ProductsCard widget;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        widget.product.productImageTable.isNotEmpty
            ? widget.product.productImageTable.first.imageUrl
            : 'https://via.placeholder.com/150',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => Container(
          color: Colors.grey[200],
          child: const Icon(Icons.image_not_supported),
        ),
      ),
    );
  }
}
