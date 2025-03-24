
  import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/home/UI/widgets/handleSearch.dart';

Widget buildSearchButton(BuildContext context, TextEditingController _searchController) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkBrown,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: handleSearch(context, _searchController),
        icon: const Icon(Icons.search, size: 20),
        label: const SizedBox.shrink(), // Empty label
      ),
    );
  }