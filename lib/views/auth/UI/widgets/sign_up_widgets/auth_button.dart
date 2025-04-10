// auth_button.dart
import 'package:flutter/material.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Widget? icon;

  const AuthButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? ElevatedButton.icon(
            onPressed: onPressed,
            icon: icon!,
            label: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: pxToSp(context, 20),
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              minimumSize: const Size(double.infinity, 50),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: pxToSp(context, 20),
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
  }
}
