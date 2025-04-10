import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/cubit/cubit/home_cubit.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_cubit.dart';
import 'package:furniture_app/views/products_details/UI/product_details.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/cubit/product_details_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class add_to_cart_button extends StatelessWidget {
  const add_to_cart_button(
      {super.key,
      required this.widget,
      required this.quantity,
      required this.state});

  final ProductDetails widget;
  final int quantity;
  final ProductDetailsState state;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: state is AddToCartLoading
          ? null // Disable button while adding
          : () {
              final cartCubit = context.read<CartCubit>();

              // Check if the product is already in the cart
              if (cartCubit.checkIsInCart(widget.product.productId)) {
                // Show a message if the product is already in the cart
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Product is already in the cart!"),
                  ),
                );
              } else {
                // If the product is not in the cart, add it
                final currentQuantity = quantity;

                cartCubit.addToCart(widget.product.productId, currentQuantity);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Added to cart successfully!"),
                  ),
                );
              }
            },
      icon: Icon(Icons.shopping_cart, color: Colors.white),
      label: Text(
        "Add To Cart",
        style: GoogleFonts.poppins(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkBrown,
        foregroundColor: Colors.white,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
