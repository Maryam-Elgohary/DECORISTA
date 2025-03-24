import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Something went wrong, please try again.",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.red,
        ),
      ),
    );
  }
}
