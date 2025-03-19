import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/components/cubit/cubit/home_cubit.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/components/products_card.dart';
import 'package:furniture_app/core/models/product_model.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    super.key,
    this.shrinkWrap,
    this.physics,
    this.query,
    this.category,
  });

  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final String? query;
  final String? category; // Ensuring category is required to avoid null errors

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit()..getProducts(query: query, category: category),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final homeCubit =
              context.read<HomeCubit>(); // Use read for performance
          List<Products> products = homeCubit.products;

          // Apply category filtering
          products = products
              .where((p) => p.categoryTable.categoryName == category)
              .toList();

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
              return ProductsCard(product: products[index]);
            },
          );
        },
      ),
    );
  }
}
