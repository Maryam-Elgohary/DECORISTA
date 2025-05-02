import 'package:flutter/material.dart';
import 'package:furniture_app/core/components/cubit/cubit/home_cubit.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/products_card/UI/products_card.dart';

class gridview_products_list extends StatelessWidget {
  const gridview_products_list({
    super.key,
    required this.shrinkWrap,
    required this.physics,
    required this.products,
    required this.homeCubit,
  });

  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final List<Products> products;
  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: shrinkWrap ?? true,
      physics: physics ?? const BouncingScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        return ProductsCard(
          isFavorite: homeCubit.checkIsFavorite(products[index].productId!),
          product: products[index],
          onTap: () {
            bool isFavorite =
                homeCubit.checkIsFavorite(products[index].productId!);
            isFavorite
                ? homeCubit.removeFavorite(products[index].productId!)
                : homeCubit.addToFavorite(products[index].productId!);
          },
        );
      },
    );
  }
}
