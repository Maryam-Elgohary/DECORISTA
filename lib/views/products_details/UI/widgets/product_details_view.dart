import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/views/home/UI/cubit/cubit/home_cubit.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/components/navigate_without_back.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/products_details/UI/product_details.dart';
import 'package:furniture_app/views/products_details/UI/widgets/ProductDetailsBottomSheet.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_body.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/cubit/product_details_cubit.dart';

/// The main view widget that builds the product details UI
class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({
    required this.product,
    required this.formKey,
    required this.commentController,
    required this.colorToImage,
    required this.selectedColor,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final Products product;
  final GlobalKey<FormState> formKey;
  final TextEditingController commentController;
  final Map<Color, String> colorToImage;
  final Color? selectedColor;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final homeCubit = context.watch<HomeCubit>();
    final iconSize = screenSize.width * 0.08;
    final imageWidth = screenSize.width;
    final imageHeight = screenSize.height * 0.5248;

    return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
      listener: (context, state) {
        if (state is AddOrUpdateRateSuccess || state is AddCommentSuccess) {
          navigateWithoutBack(
              context,
              ProductDetails(
                product: product,
                isFav: homeCubit.checkIsFavorite(product.productId!),
              ));
        }
      },
      builder: (context, state) {
        final cubit = context.read<ProductDetailsCubit>();

        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: state is GetRateLoading || state is AddCommentLoading
                ? const CustomCircleProIndicator()
                : ProductDetailsBody(
                    imageWidth: imageWidth,
                    imageHeight: imageHeight,
                    homeCubit: homeCubit,
                    iconSize: iconSize,
                    cubit: cubit,
                    widget: ProductDetails(
                      product: product,
                      isFav: homeCubit.checkIsFavorite(product.productId!),
                    ),
                    formKey: formKey,
                    colorToImage: colorToImage,
                    commentController: commentController,
                  ),
            bottomSheet: ProductDetailsBottomSheet(
              widget: ProductDetails(
                product: product,
                isFav: homeCubit.checkIsFavorite(product.productId!),
              ),
              quantity: quantity,
              state: state,
              onIncrease: onIncrement,
              onDecrease: onDecrement,
            ),
          ),
        );
      },
    );
  }
}
