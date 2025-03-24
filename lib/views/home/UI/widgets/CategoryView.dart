import 'package:flutter/material.dart';
import 'package:furniture_app/views/home/UI/widgets/CategoryTabs.dart';
import 'package:furniture_app/views/home/UI/widgets/ProductsSection.dart';

class CategoryView extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  const CategoryView({
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTabs(
          categories: categories,
          selectedIndex: selectedIndex,
          onTap: onCategorySelected,
        ),
        const SizedBox(height: 10),
        ProductsSection(category: categories[selectedIndex]['name']),
      ],
    );
  }
}
