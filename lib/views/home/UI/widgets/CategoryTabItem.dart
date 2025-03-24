import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

class CategoryTabItem extends StatelessWidget {
  final Map<String, dynamic> category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryTabItem({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.darkBrown : Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.3,
          child: Text(
            category['name'],
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: isSelected ? Colors.white : AppColors.darkBrown,
            ),
          ),
        ),
      ),
    );
  }
}
