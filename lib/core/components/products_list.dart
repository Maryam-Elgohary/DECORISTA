import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/components/cubit/cubit/home_cubit.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/components/products_card.dart';
import 'package:furniture_app/core/models/product_model';

class ProductsList extends StatelessWidget {
  const ProductsList({
    super.key,
    this.shrinkWrap,
    this.physics,
  });
  final bool? shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          List<ProductModel> products = context.read<HomeCubit>().products;
          return state is GetDataLoading
              ? const CustomCircleProIndicator()
              : GridView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductsCard(
                     name: product['productName'],
                    );
                  },
                );
        },
      ),
    );
  }
}
