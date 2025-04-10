import 'package:flutter/material.dart';
import 'package:furniture_app/views/products_details/UI/product_details.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_description_part.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_description_rate_row.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_name_price.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_rating_bar.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/cubit/product_details_cubit.dart';

class product_details_under_image extends StatelessWidget {
  const product_details_under_image({
    super.key,
    required this.widget,
    required this.cubit,
  });

  final ProductDetails widget;
  final ProductDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          product_details_name_price(widget: widget),
          const SizedBox(height: 10),
          product_details_description_rate_row(cubit: cubit),
          // const SizedBox(height: 10),
          product_details_description_part(widget: widget),
          product_details_rating_bar(cubit: cubit, widget: widget),
          //   const SizedBox(height: 10),
        ],
      ),
    );
  }
}
