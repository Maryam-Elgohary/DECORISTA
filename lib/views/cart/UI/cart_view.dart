import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/functions/api_services.dart';
import 'package:furniture_app/core/functions/supabase_manager.dart';
import 'package:furniture_app/views/cart/UI/widgets/bloc_consumer_cart_view.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_cubit.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/supabase_cart_repository.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  double shippingCost = 50;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(
        cartRepository: SupabaseCartRepository(ApiServices()),
        supabaseManager: SupabaseManager(),
      )..getCartProducts(),
      child: bloc_consumer_cart_view(shippingCost: shippingCost),
    );
  }
}
