import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/components/cubit/cubit/home_cubit.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/products_list/UI/Widgets/gridview_products_list.dart';

class bloc_consumer_products_list extends StatelessWidget {
  const bloc_consumer_products_list({
    super.key,
    required this.query,
    required this.category,
    required this.discount,
    required this.isFavoriteView,
    required this.shrinkWrap,
    required this.physics,
  });

  final String? query;
  final String? category;
  final int? discount;
  final bool isFavoriteView;
  final bool? shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (BuildContext context, HomeState state) {},
      builder: (context, state) {
        HomeCubit homeCubit = context.read<HomeCubit>();

        List<Products> products = homeCubit.products;

        // Apply category filtering
        if (query != null) {
          products = products
              .where((p) => p.productName
                      .toLowerCase()
                      .contains(query!.toLowerCase()) // Case-insensitive search
                  )
              .toList();
          context.read<HomeCubit>().searchResults;
        }
        if (category != null) {
          context.read<HomeCubit>().categoryProducts;
          products = products
              .where((p) =>
                  p.categoryTable.categoryName.toLowerCase() ==
                  category?.toLowerCase())
              .toList();
        }
        if (discount != null) {
          products = products
              .where((p) =>
                  p.specialOffersTable.isNotEmpty &&
                  p.specialOffersTable.first.discount == discount)
              .toList();
        }
        if (isFavoriteView) {
          homeCubit.favoriteProductList;
          products = products
              .where((p) => p.favoriteTable.any((f) => f.isFavorite))
              .toList();
        }

        if (state is GetDataLoading) {
          return const Center(child: CustomCircleProIndicator());
        }

        if (products.isEmpty) {
          return const Center(
            child: Text(
              "No products found in this category.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          );
        }

        return gridview_products_list(
            shrinkWrap: shrinkWrap,
            physics: physics,
            products: products,
            homeCubit: homeCubit);
      },
    );
  }
}
