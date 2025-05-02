import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/navigate_without_back.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_cubit.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_state.dart';
import 'package:furniture_app/views/navbar/UI/main_home_view.dart';
import 'package:google_fonts/google_fonts.dart';

class alert_dialog_yes_button extends StatelessWidget {
  const alert_dialog_yes_button({
    super.key,
    required this.state,
  });

  final CartState state;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: state is RemoveFromCartLoading
          ? null // Disable button while loading
          : () {
              final cartCubit = context.read<CartCubit>();
              cartCubit.removeAllFromCart();
              navigateWithoutBack(
                context,
                MainHomeView(
                  userDataModel:
                      context.read<AuthenticationCubit>().userDataModel!,
                ),
              );
            },
      child: Text(
        'Yes',
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: AppColors.darkBrown,
        ),
      ),
    );
  }
}
