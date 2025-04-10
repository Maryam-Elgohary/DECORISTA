import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/products_details/UI/product_details.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/cubit/product_details_cubit.dart';

class product_details_send_button extends StatelessWidget {
  const product_details_send_button({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController commentController,
    required this.cubit,
    required this.widget,
  })  : _formKey = formKey,
        _commentController = commentController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _commentController;
  final ProductDetailsCubit cubit;
  final ProductDetails widget;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            //  minimumSize: Size(10, 55),
            backgroundColor: AppColors.darkBrown,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            if (_commentController.text.isEmpty) {
              // Show an error message or handle the empty fields case
              return;
            }
            await context.read<AuthenticationCubit>().getUserData();
            await cubit.addComment(data: {
              "comment": _commentController.text,
              "user_id": cubit.userId,
              "product_id": widget.product.productId,
              "user_name":
                  "${context.read<AuthenticationCubit>().userDataModel?.firstName} ${context.read<AuthenticationCubit>().userDataModel?.lastName}" ??
                      "User Name"
            });
          }

          _commentController.clear();
        },
        label: const Icon(
          Icons.send,
          size: 25,
        ));
  }
}
