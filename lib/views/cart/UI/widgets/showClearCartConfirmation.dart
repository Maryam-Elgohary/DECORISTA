
  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/navigate_without_back.dart';
import 'package:furniture_app/views/cart/UI/cart_view.dart';
import 'package:furniture_app/views/cart/logic/cubit/cart_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

void showClearCartConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Clear Cart',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),
        content: Text(
          'Are you sure you want to clear your cart?',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: AppColors.darkBrown,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: AppColors.darkBrown,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<CartCubit>().removeAllFromCart();
              Navigator.pop(context);
              navigateWithoutBack(context, const CartView());
            },
            child: Text(
              'Clear',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }