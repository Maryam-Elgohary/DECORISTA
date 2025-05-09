import 'package:flutter/material.dart';
import 'package:furniture_app/views/products_list/UI/products_list.dart';
import 'package:furniture_app/core/components/build_appbar.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, required this.query});
  final String query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Search Results"),
      body: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          ProductsList(
            query: query,
          )
        ],
      ),
    );
  }
}
