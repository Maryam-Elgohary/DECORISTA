import 'package:flutter/material.dart';

class CategoryImage extends StatelessWidget {
  final String imageUrl;

  const CategoryImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl,
        width: 60,
        height: 80,
        fit: BoxFit.cover,
      ),
    );
  }
}
