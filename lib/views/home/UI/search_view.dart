import 'package:flutter/material.dart';
import 'package:furniture_app/core/functions/build_appbar.dart';
import 'package:furniture_app/views/home/UI/widgets/SearchResults.dart';

class SearchView extends StatelessWidget {
  final String query;

  const SearchView({
    super.key,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Search Results"),
      body: const SearchResults(),
    );
  }
}
