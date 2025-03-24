import 'package:flutter/material.dart';
import 'package:furniture_app/views/auth/UI/widgets/input_decoration.dart';

Widget buildCustomField(
    TextEditingController fieldController,
    String? validateField(String? value),
    TextInputType fieldType,
    String text) {
  return TextFormField(
    controller: fieldController,
    validator: validateField,
    decoration: inputDecoration(text),
    keyboardType: fieldType,
  );
}
