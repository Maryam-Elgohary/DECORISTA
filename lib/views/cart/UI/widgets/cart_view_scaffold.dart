import 'package:flutter/material.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/cart/UI/cart_view.dart';
import 'package:furniture_app/views/cart/UI/widgets/Cart_AppBar.dart';
import 'package:furniture_app/views/cart/UI/widgets/bottomsheet_container.dart';
import 'package:furniture_app/views/cart/UI/widgets/cart_body.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_cubit.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_state.dart';

class cart_view_scaffold extends StatelessWidget {
  const cart_view_scaffold({
    super.key,
    required this.products,
    required this.cartCubit,
    required this.subtotal,
    required this.shippingCost,
    required this.state,
  });

  final List<Products> products;
  final CartCubit cartCubit;
  final double subtotal;
  final double shippingCost;
  final CartState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: CartAppBar(state: state),
      body: cart_body(products: products, cartCubit: cartCubit),
      bottomSheet: products.isEmpty
          ? Container(
              height: 0,
            )
          : bottomsheet_container(
              subtotal: subtotal, shippingCost: shippingCost),
    );
  }
}
