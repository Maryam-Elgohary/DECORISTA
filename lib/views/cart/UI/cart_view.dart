import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/functions/api_services.dart';
import 'package:furniture_app/views/cart/UI/widgets/build_appbar.dart';
import 'package:furniture_app/views/cart/UI/widgets/build_order_summary.dart';
import 'package:furniture_app/views/cart/UI/widgets/build_product_list.dart';
import 'package:furniture_app/views/cart/UI/widgets/calculate_subtotal.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cart_repository.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_cubit.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Create ApiServices instance
    final apiServices = ApiServices();

// 2. Create CartRepository instance
    final cartRepository = SupabaseCartRepository(apiServices);

// 3. Get Supabase client instance
    final supabase = Supabase.instance.client;
    return BlocProvider(
      create: (context) => CartCubit(
        cartRepository: cartRepository,
        supabase: Supabase.instance.client,
      )..getCartProducts(),
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
