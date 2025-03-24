import 'package:flutter/material.dart';

InputBorder buildInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius:
        BorderRadius.circular(100), // Using fixed radius for consistency
    borderSide: BorderSide.none,
  );
}
