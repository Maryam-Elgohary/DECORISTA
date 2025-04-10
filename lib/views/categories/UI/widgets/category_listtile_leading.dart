import 'package:flutter/material.dart';

class category_listtile_leading extends StatelessWidget {
  const category_listtile_leading({
    super.key,
    required this.category,
  });

  final Map<String, dynamic> category;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network("${category['image_url']}",
          width: 60, height: 80, fit: BoxFit.cover),
    );
  }
}
