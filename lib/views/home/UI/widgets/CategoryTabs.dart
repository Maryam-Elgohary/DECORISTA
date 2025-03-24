import 'package:flutter/material.dart';
import 'package:furniture_app/views/home/UI/widgets/CategoryTabItem.dart';

class CategoryTabs extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CategoryTabs({
    required this.categories,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => CategoryTabItem(
          category: categories[index],
          isSelected: index == selectedIndex,
          onTap: () => onTap(index),
        ),
      ),
    );
  }
}
