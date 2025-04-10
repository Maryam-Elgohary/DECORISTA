import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:furniture_app/views/products_details/UI/product_details.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/cubit/product_details_cubit.dart';

class product_details_rating_bar extends StatelessWidget {
  const product_details_rating_bar({
    super.key,
    required this.cubit,
    required this.widget,
  });

  final ProductDetailsCubit cubit;
  final ProductDetails widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RatingBar.builder(
        initialRating: cubit.userRate.toDouble(),
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          cubit
              .addOrUpdateUserRate(productId: widget.product.productId!, data: {
            "rate": rating.toInt(),
            "user_id": cubit.userId,
            "product_id": widget.product.productId
          });
        },
      ),
    );
  }
}
