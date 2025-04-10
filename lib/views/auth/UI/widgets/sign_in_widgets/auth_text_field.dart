import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPassword;
  final bool isPasswordHidden;
  final VoidCallback? onTogglePasswordVisibility;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
    this.isPasswordHidden = true,
    this.onTogglePasswordVisibility,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        fillColor: const Color(0xfff4f4f4),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: onTogglePasswordVisibility,
                icon: Icon(
                  isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.darkBrown,
                ),
              )
            : null,
      ),
      keyboardType: keyboardType,
      obscureText: isPassword && isPasswordHidden,
    );
  }
}
