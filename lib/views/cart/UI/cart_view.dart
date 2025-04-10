import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/api_services.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/core/functions/navigate_without_back.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/cart/UI/widgets/bottomsheet_container.dart';
import 'package:furniture_app/views/cart/UI/widgets/cart_body.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cart_repository.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_cubit.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_state.dart';
import 'package:furniture_app/views/navbar/UI/main_home_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
        supabase: Supabase.instance.client,
      )..getCartProducts(),
      child: BlocConsumer<CartCubit, CartState>(
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

          return Scaffold(
            backgroundColor: const Color(0xfff4f4f4),
            appBar: cart_appbar(context, state),
            body: cart_body(products: products, cartCubit: cartCubit),
            bottomSheet: products.isEmpty
                ? Container(
                    height: 0,
                  )
                : bottomsheet_container(
                    subtotal: subtotal, shippingCost: shippingCost),
          );
        },
        listener: (BuildContext context, CartState state) {},
      ),
    );
  }

  AppBar cart_appbar(BuildContext context, CartState state) {
    return AppBar(
      foregroundColor: Colors.transparent,
      centerTitle: true,
      title: Text("Shopping",
          style: GoogleFonts.poppins(
              fontSize: 24,
              color: AppColors.darkBrown,
              fontWeight: FontWeight.w500)),
      backgroundColor: Colors.transparent,
      leading: IconButton(
          onPressed: () {
            navigate_to_main_home(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.darkBrown,
          )),
      actions: [delete_all_from_cart(context, state)],
    );
  }

  Future<dynamic> navigate_to_main_home(BuildContext context) {
    return naviagteTo(
        context,
        MainHomeView(
            userDataModel: context.read<AuthenticationCubit>().userDataModel!));
  }

  IconButton delete_all_from_cart(BuildContext context, CartState state) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Delete Product',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),
              content: Text(
                'Are you sure you want to delete this product from the cart?',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: AppColors.darkBrown,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    'No',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: AppColors.darkBrown,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: state is RemoveFromCartLoading
                      ? null // Disable button while adding
                      : () {
                          final cartCubit = context.read<CartCubit>();
                          cartCubit.removeAllFromCart();
                          setState(() {});
                          // Navigator.pop(context);
                          navigateWithoutBack(
                              context,
                              MainHomeView(
                                  userDataModel: context
                                      .read<AuthenticationCubit>()
                                      .userDataModel!));
                        },
                  child: Text(
                    'Yes',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: AppColors.darkBrown,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      icon: const Icon(
        Icons.delete,
        color: AppColors.darkBrown,
      ),
    );
  }
}
