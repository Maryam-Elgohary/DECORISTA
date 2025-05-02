import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/navigate_to.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/cart/UI/widgets/DeleteAllCartButton.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_state.dart';
import 'package:furniture_app/views/navbar/UI/main_home_view.dart';
import 'package:google_fonts/google_fonts.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  final CartState state;

  const CartAppBar({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        "Shopping",
        style: GoogleFonts.poppins(
          fontSize: 24,
          color: AppColors.darkBrown,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {
          naviagteTo(
            context,
            MainHomeView(
              userDataModel: context.read<AuthenticationCubit>().userDataModel!,
            ),
          );
        },
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.darkBrown,
        ),
      ),
      actions: [
        DeleteAllCartButton(state: state),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
