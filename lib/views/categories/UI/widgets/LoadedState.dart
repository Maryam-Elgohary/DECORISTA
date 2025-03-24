import 'package:flutter/material.dart';
import 'package:furniture_app/views/categories/UI/widgets/CategoryItem.dart';

class LoadedState extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const LoadedState({required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return CategoryItem(category: categories[index]);
      },
    );
  }
}
