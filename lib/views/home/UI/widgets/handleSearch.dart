import 'package:flutter/material.dart';
import 'package:furniture_app/views/home/UI/search_view.dart';

handleSearch(BuildContext context, TextEditingController _searchController) {
  final query = _searchController.text.trim();
  if (query.isNotEmpty) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchView(query: query),
      ),
    );
    _searchController.clear();
  }
}
