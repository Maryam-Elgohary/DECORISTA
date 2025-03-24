import 'package:flutter/material.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/checkout/UI/check_out.dart';

void navigateToCheckout(
    double subtotal, BuildContext context, double shippingCost) {
  naviagteTo(
    context,
    CheckOut(
      subtotal: subtotal,
      shippingCost: shippingCost,
    ),
  );
}
