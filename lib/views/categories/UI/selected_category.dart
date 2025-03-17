import 'package:flutter/material.dart';
import 'package:furniture_app/core/components/products_list.dart';
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
        body: widget.title == "Chair"
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: ProductsList(),
              )
            : Container());
  }
}
