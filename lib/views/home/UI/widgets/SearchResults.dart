import 'package:flutter/material.dart';
import 'package:furniture_app/core/components/products_list.dart';
import 'package:furniture_app/views/home/UI/search_view.dart';

class SearchResults extends StatelessWidget {
  const SearchResults();

  @override
  Widget build(BuildContext context) {
    final searchView = context.findAncestorWidgetOfExactType<SearchView>();
    final query = searchView?.query ?? '';

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ProductsList(
        query: query,
      ),
    );
  }
}
