import 'package:flutter/material.dart';
import 'package:furniture_app/views/products_details/UI/product_details.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_comment_field.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_send_button.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/cubit/product_details_cubit.dart';

class product_details_comments_part extends StatelessWidget {
  const product_details_comments_part({
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              height: 50,
              child: Form(
                key: _formKey,
                child: product_details_comment_field(
                    commentController: _commentController),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            height: 50,
            child: product_details_send_button(
                formKey: _formKey,
                commentController: _commentController,
                cubit: cubit,
                widget: widget),
          )
        ],
      ),
    );
  }
}
