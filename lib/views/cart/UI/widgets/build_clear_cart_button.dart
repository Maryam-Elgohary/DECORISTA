import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/cart/UI/widgets/showClearCartConfirmation.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_cubit.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_state.dart';

Widget buildClearCartButton() {
  return BlocBuilder<CartCubit, CartState>(
    builder: (context, state) {
      return IconButton(
        onPressed: () => showClearCartConfirmation(context),
        icon: const Icon(Icons.delete, color: AppColors.darkBrown),
      );
    },
  );
}
