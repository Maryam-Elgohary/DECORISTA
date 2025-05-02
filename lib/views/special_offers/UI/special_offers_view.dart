import 'package:flutter/material.dart';
import 'package:furniture_app/views/products_list/UI/products_list.dart';
import 'package:furniture_app/core/functions/build_appbar.dart';

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({super.key, required this.discount});
  final int discount;

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildCustomAppBar(context, "Special Offers"),
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: ProductsList(
              discount: widget.discount,
            )));
  }
}
