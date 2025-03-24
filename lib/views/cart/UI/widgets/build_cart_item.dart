import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/cart/UI/widgets/build_product_details.dart';
import 'package:furniture_app/views/cart/UI/widgets/build_product_image.dart';
import 'package:furniture_app/views/cart/UI/widgets/build_quantity_controls.dart';
import 'package:furniture_app/views/cart/logic/cubit/cart_cubit.dart';

Widget buildCartItem(Products item, BuildContext context) {
  final cartCubit = context.read<CartCubit>();
  final currentQuantity = item.quantity ?? 1;

  return Card(
    color: Colors.white,
    margin: const EdgeInsets.only(bottom: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          buildProductImage(item),
          const SizedBox(width: 16),
          Expanded(child: buildProductDetails(item)),
          buildQuantityControls(item, cartCubit, currentQuantity),
        ],
      ),
    ),
  );
}
