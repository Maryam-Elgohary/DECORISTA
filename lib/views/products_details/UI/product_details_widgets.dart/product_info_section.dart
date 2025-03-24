import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/cubit/product_details_cubit.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/cubit/product_details_state.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({required this.product});

  final Products product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                child: Text(
                  product.productName,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              product.hasDiscount
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            decoration: TextDecoration.lineThrough,
                            color: AppColors.lightBrown,
                          ),
                        ),
                        Text(
                          '\$${product.discountedPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.orangeColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppColors.orangeColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffAB886D),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 25),
                  const SizedBox(width: 4),
                  // BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                  //   builder: (context, state) {
                  //     final cubit = context.read<ProductDetailsCubit>();
                  //     return Text(
                  //       '${cubit.averageRate}',
                  //       style: GoogleFonts.poppins(
                  //         color: AppColors.darkBrown,
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.w500,
                  //       ),
                  //     );
                  //   },
                  // ),
                  BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                    builder: (context, state) {
                      return Text(
                        state is RatesLoaded
                            ? state.averageRate.toStringAsFixed(1)
                            : state is ProductDetailsLoading
                                ? '...'
                                : '0.0',
                        style: GoogleFonts.poppins(
                          color: AppColors.darkBrown,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Text(
              product.description,
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: const Color(0xffAB886D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
