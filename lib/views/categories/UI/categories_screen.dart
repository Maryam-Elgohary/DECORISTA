import 'package:flutter/material.dart';
import 'package:furniture_app/core/functions/build_appbar.dart';
import 'package:furniture_app/views/categories/UI/widgets/CategoriesListView.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Categories"),
      body: const CategoriesListView(),
      backgroundColor: Colors.grey[100],
    );
  }
}
