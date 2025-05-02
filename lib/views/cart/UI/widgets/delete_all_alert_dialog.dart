import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/cart/UI/widgets/alert_dialog_no_button.dart';
import 'package:furniture_app/views/cart/UI/widgets/alert_dialog_yes_button.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_state.dart';
import 'package:google_fonts/google_fonts.dart';

class delete_all_alert_dialog extends StatelessWidget {
  const delete_all_alert_dialog({
    super.key,
    required this.state,
    required this.dialogContext,
  });

  final CartState state;
  final BuildContext dialogContext;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Delete All Products',
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.darkBrown,
        ),
      ),
      content: Text(
        'Are you sure you want to delete all products from the cart?',
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: AppColors.darkBrown,
        ),
      ),
      actions: <Widget>[
        alert_dialog_no_button(dialogContext: dialogContext),
        alert_dialog_yes_button(state: state),
      ],
    );
  }
}
