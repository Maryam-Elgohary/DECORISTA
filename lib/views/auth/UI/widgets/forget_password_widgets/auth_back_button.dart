import 'package:flutter/material.dart';

class AuthBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AuthBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xfff4f4f4),
        ),
      ),
      onPressed: onPressed,
      icon: const Icon(Icons.arrow_back),
    );
  }
}
