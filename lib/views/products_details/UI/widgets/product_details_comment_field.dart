import 'package:flutter/material.dart';

class product_details_comment_field extends StatelessWidget {
  const product_details_comment_field({
    super.key,
    required TextEditingController commentController,
  }) : _commentController = commentController;

  final TextEditingController _commentController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      controller: _commentController,
      decoration: InputDecoration(
        fillColor: Color(0xfff4f4f4),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        filled: true,
        //hintText: "Add a review",
        labelText: "Add a review",
      ),
    );
  }
}
