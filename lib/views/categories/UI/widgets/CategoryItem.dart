import 'package:flutter/material.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/categories/UI/selected_category.dart';
import 'package:furniture_app/views/categories/UI/widgets/CategoryImage.dart';
import 'package:furniture_app/views/categories/UI/widgets/ForwardIcon.dart';

class CategoryItem extends StatelessWidget {
  final Map<String, dynamic> category;

  const CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ListTile(
        leading: CategoryImage(imageUrl: category['image_url']),
        title: Text(
          category['name'],
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: const ForwardIcon(),
        onTap: () => _navigateToCategory(context, category['name']),
      ),
    );
  }

  void _navigateToCategory(BuildContext context, String categoryName) {
    naviagteTo(
      context,
      SelectedCategory(title: categoryName),
    );
  }
}
