import 'package:flutter/material.dart';
import 'package:furniture_app/views/products_list/UI/products_list.dart';
import 'package:furniture_app/core/functions/build_appbar.dart';

class SelectedCategory extends StatefulWidget {
  const SelectedCategory({super.key, required this.title});
  final String title;
  @override
  State<SelectedCategory> createState() => _SelectedCategoryState();
}

class _SelectedCategoryState extends State<SelectedCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildCustomAppBar(context, widget.title),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ProductsList(
            category: widget.title,
          ),
        ));
  }
}
