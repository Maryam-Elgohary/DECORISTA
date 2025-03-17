import 'package:flutter/material.dart';
import 'package:furniture_app/core/functions/build_appbar.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/categories/UI/selected_category.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"image": "assets/chair.png", "name": "Chair", "count": 4},
    {"image": "assets/table.png", "name": "Tables", "count": 126},
    {"image": "assets/sofa.png", "name": "Sofa", "count": 236},
    {"image": "assets/wardrobe.png", "name": "Wardrobes", "count": 375},
    {"image": "assets/lamp.png", "name": "Lamps", "count": 946},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Categories"),
      body: ListView.builder(
        itemCount: categories.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final category = categories[index];
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
                    spreadRadius: 1),
              ],
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(category["image"],
                    width: 60, height: 80, fit: BoxFit.cover),
              ),
              title: Text(category["name"],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text("${category["count"]} products",
                  style: const TextStyle(color: Colors.grey)),
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 18, color: Colors.grey),
              onTap: () {
                naviagteTo(
                    context,
                    SelectedCategory(
                      title: category["name"],
                    ));
              },
            ),
          );
        },
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
