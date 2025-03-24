import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/views/cart/UI/widgets/build_appbar.dart';
import 'package:furniture_app/views/cart/UI/widgets/build_order_summary.dart';
import 'package:furniture_app/views/cart/UI/widgets/build_product_list.dart';
import 'package:furniture_app/views/cart/UI/widgets/calculate_subtotal.dart';
import 'package:furniture_app/views/cart/logic/cubit/cart_cubit.dart';
import 'package:furniture_app/views/cart/logic/cubit/cart_state.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCartProducts(),
      child: const _CartViewContent(),
    );
  }
}

class _CartViewContent extends StatefulWidget {
  const _CartViewContent();

  @override
  State<_CartViewContent> createState() => _CartViewContentState();
}

class _CartViewContentState extends State<_CartViewContent> {
  final double shippingCost = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: buildAppBar(context),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cartCubit = context.read<CartCubit>();
          final products = cartCubit.cartProducts;
          final subtotal = calculateSubtotal(products);

          return Column(
            children: [
              Expanded(
                child: buildProductList(products),
              ),
              if (products.isNotEmpty)
                buildOrderSummary(subtotal, context, shippingCost),
            ],
          );
        },
      ),
    );
  }
}
