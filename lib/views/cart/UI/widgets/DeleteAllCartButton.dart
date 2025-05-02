import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/cart/UI/widgets/delete_all_alert_dialog.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_state.dart';

class DeleteAllCartButton extends StatelessWidget {
  final CartState state;

  const DeleteAllCartButton({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _showDeleteConfirmationDialog(context);
      },
      icon: const Icon(
        Icons.delete,
        color: AppColors.darkBrown,
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return delete_all_alert_dialog(
          state: state,
          dialogContext: dialogContext,
        );
      },
    );
  }
}
