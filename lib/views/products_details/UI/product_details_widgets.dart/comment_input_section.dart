import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

class CommentInputSection extends StatelessWidget {
  const CommentInputSection({
    required this.formKey,
    required this.controller,
    required this.onSendPressed,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final VoidCallback onSendPressed;

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
                key: formKey,
                child: TextFormField(
                  controller: controller,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'This field is required' : null,
                  decoration: InputDecoration(
                    fillColor: const Color(0xfff4f4f4),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    labelText: 'Add a review',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkBrown,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: onSendPressed,
              label: const Icon(Icons.send, size: 25),
            ),
          ),
        ],
      ),
    );
  }
}
