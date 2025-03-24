import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/cart/UI/widgets/quantity_button.dart';
import 'package:furniture_app/views/cart/logic/cubit/cart_cubit.dart';

Widget buildQuantityControls(
  Products item,
  CartCubit cartCubit,
  int currentQuantity,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      IconButton(
        onPressed: () => cartCubit.removeFromCart(item.productId),
        icon: const Icon(Icons.delete, color: AppColors.orangeColor),
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          QuantityButton(
            icon: Icons.remove,
            color: const Color(0xfff0f0f2),
            iconColor: const Color(0xff828A89),
            onPressed: currentQuantity > 1
                ? () => cartCubit.updateQuantity(
                      item.productId,
                      currentQuantity - 1,
                    )
                : null,
          ),
          const SizedBox(width: 10),
          Text('$currentQuantity', style: _quantityTextStyle),
          const SizedBox(width: 10),
          QuantityButton(
            icon: Icons.add,
            color: AppColors.darkBrown,
            iconColor: Colors.white,
            onPressed: () => cartCubit.updateQuantity(
              item.productId,
              currentQuantity + 1,
            ),
          ),
        ],
      ),
    ],
  );
}

final TextStyle _quantityTextStyle = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);
