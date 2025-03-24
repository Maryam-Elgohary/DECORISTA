import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/cart/UI/widgets/build_clear_cart_button.dart';
import 'package:furniture_app/views/cart/UI/widgets/navigate_to_home.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar buildAppBar(BuildContext context) {
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
      onPressed: () => navigateToHome(context),
      icon: const Icon(Icons.arrow_back, color: AppColors.darkBrown),
    ),
    actions: [buildClearCartButton()],
  );
}
