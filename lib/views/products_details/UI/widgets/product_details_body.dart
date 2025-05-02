import 'package:flutter/material.dart';
import 'package:furniture_app/core/components/cubit/cubit/home_cubit.dart';
import 'package:furniture_app/views/products_details/UI/comments_list.dart';
import 'package:furniture_app/views/products_details/UI/product_details.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_comments_part.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_image_stack.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_reviews_text.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_under_image.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/cubit/product_details_cubit.dart';

class ProductDetailsBody extends StatelessWidget {
  final double imageWidth;
  final double imageHeight;
  final HomeCubit homeCubit;
  final double iconSize;
  final ProductDetailsCubit cubit;
  final ProductDetails widget;
  final GlobalKey<FormState> formKey;
  final Map<Color, String> colorToImage;
  final TextEditingController commentController;

  const ProductDetailsBody({
    super.key,
    required this.imageWidth,
    required this.imageHeight,
    required this.homeCubit,
    required this.iconSize,
    required this.cubit,
    required this.widget,
    required this.formKey,
    required this.colorToImage,
    required this.commentController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ProductDetailsImageStack(
            widget: widget,
            homeCubit: homeCubit,
            iconSize: iconSize,
            colorToImage: colorToImage,
            imageWidth: imageWidth,
            imageHeight: imageHeight,
          ),
          product_details_under_image(widget: widget, cubit: cubit),
          product_details_comments_part(
            formKey: formKey,
            commentController: commentController,
            cubit: cubit,
            widget: widget,
          ),
          const SizedBox(height: 10),
          const product_details_reviews_text(),
          CommentsList(
            productModel: widget.product,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.22,
          ),
        ],
      ),
    );
  }
}
