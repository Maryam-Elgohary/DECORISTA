import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/cart/UI/cart_view.dart';
import 'package:furniture_app/views/cart/UI/widgets/cart_view_scaffold.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_cubit.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_state.dart';

class bloc_consumer_cart_view extends StatelessWidget {
  const bloc_consumer_cart_view({
    super.key,
    required this.shippingCost,
  });

  final double shippingCost;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      builder: (context, state) {
        CartCubit cartCubit = context.read<CartCubit>();
        List<Products> products = cartCubit.cartProducts ?? [];

        // Calculate subtotal with discount applied
        double subtotal = products.fold(0.0, (sum, item) {
          double discountedPrice = item.price.toDouble();
          if (item.specialOffersTable != null &&
              item.specialOffersTable.isNotEmpty) {
            // Ensure the discount is valid
            double discount = item.specialOffersTable.first.discount
                .toDouble(); // Convert to double
            if (discount > 0.0 && discount <= 100.0) {
              discountedPrice =
                  (item.price * ((100 - discount) / 100)).toDouble();
              print(
                  "Product: ${item.productName}, Original Price: ${item.price}, Discount: $discount%, Discounted Price: $discountedPrice");
            } else {
              print(
                  "Invalid discount for product: ${item.productName}. Discount: $discount");
            }
          } else {
            print("No discount for product: ${item.productName}");
          }
          return sum + (discountedPrice * (item.quantity ?? 1));
        });

        return cart_view_scaffold(
          products: products,
          cartCubit: cartCubit,
          subtotal: subtotal,
          shippingCost: shippingCost,
          state: state,
        );
      },
      listener: (BuildContext context, CartState state) {},
    );
  }
}
