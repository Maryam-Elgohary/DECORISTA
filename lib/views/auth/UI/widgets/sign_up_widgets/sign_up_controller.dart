// sign_up_controller.dart

import 'package:flutter/material.dart';

class SignUpController {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;

  String? validateRequired(String? value, String fieldName) =>
      value?.isEmpty ?? true ? "$fieldName is required" : null;

  String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) return "Email is required";
    if (!value!.contains('@')) return "Invalid email format";
    return null;
  }

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
  }

  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    password.dispose();
  }
}
