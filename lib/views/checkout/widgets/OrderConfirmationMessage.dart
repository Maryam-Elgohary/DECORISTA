
import 'package:flutter/material.dart';

class OrderConfirmationMessage extends StatelessWidget {
  const OrderConfirmationMessage();

  @override
  Widget build(BuildContext context) {
    return Text(
      "Your order have been placed successfully!",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xff828A89),
        fontSize: 20,
      ),
    );
  }
}