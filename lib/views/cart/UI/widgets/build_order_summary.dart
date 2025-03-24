import 'package:flutter/material.dart';
import 'package:furniture_app/views/cart/UI/widgets/build_checkout_button.dart';
import 'package:furniture_app/views/cart/UI/widgets/build_summary_row.dart';

Widget buildOrderSummary(
    double subtotal, BuildContext context, double shippingCost) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildSummaryRow('Subtotal', subtotal),
        const SizedBox(height: 8),
        buildSummaryRow('Shipping Cost', shippingCost),
        const Divider(color: Color(0xfff0f0f2)),
        const SizedBox(height: 8),
        buildSummaryRow(
          'Total Payment',
          subtotal + shippingCost,
          isTotal: true,
        ),
        const SizedBox(height: 16),
        buildCheckoutButton(subtotal, context, shippingCost),
      ],
    ),
  );
}
