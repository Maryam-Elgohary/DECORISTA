import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.darkBrown : Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text(
                  categories[index].text,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: pxToSp(context, 16),
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

List<Category> categories = [
  Category(icon: Icons.sports, text: "Chair"),
  Category(icon: Icons.tv, text: "Tables"),
  Category(icon: Icons.collections, text: "Sofa"),
  Category(icon: Icons.book, text: "Cupboard"),
  Category(icon: Icons.games, text: "Lamps"),
  Category(icon: Icons.bike_scooter, text: "Beds"),
];

class Category {
  final IconData icon;
  final String text;

  Category({required this.icon, required this.text});
}
