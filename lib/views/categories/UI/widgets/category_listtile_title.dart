import 'package:flutter/material.dart';

class category_listtile_title extends StatelessWidget {
  const category_listtile_title({
    super.key,
    required this.category,
  });

  final Map<String, dynamic> category;

  @override
  Widget build(BuildContext context) {
    return Text(category['name'],
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }
}
