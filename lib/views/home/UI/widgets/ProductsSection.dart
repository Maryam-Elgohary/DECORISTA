import 'package:flutter/material.dart';
import 'package:furniture_app/core/components/products_list.dart';

class ProductsSection extends StatelessWidget {
  final String category;

  const ProductsSection({required this.category});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500, // Consider making this dynamic based on content
      child: ProductsList(category: category),
    );
  }
}
