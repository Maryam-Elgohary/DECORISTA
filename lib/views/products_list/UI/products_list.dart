import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/components/cubit/cubit/home_cubit.dart';
import 'package:furniture_app/views/products_list/UI/Widgets/bloc_consumer_products_list.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    super.key,
    this.shrinkWrap,
    this.physics,
    this.query,
    this.category,
    this.isFavoriteView = false,
    this.discount,
  });

  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final String? query;
  final String? category; // Ensuring category is required to avoid null errors
  final bool isFavoriteView;
  final int? discount;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<HomeCubit>()
        ..getProducts(query: query, category: category, discount: discount),
      child: bloc_consumer_products_list(
          query: query,
          category: category,
          discount: discount,
          isFavoriteView: isFavoriteView,
          shrinkWrap: shrinkWrap,
          physics: physics),
    );
  }
}
