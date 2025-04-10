import 'package:flutter/material.dart';
import 'package:furniture_app/views/checkout/UI/check_out.dart';
import 'package:furniture_app/views/checkout/UI/widgets/checkout_order_summary.dart';

class checkout_bottom_sheet extends StatelessWidget {
  const checkout_bottom_sheet({
    super.key,
    required this.widget,
    required this.totalPayment,
    required this.selectedPaymentMethod,
  });

  final CheckOut widget;
  final double totalPayment;
  final int selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.35,
      child: checkout_order_summary(
          widget: widget,
          totalPayment: totalPayment,
          selectedPaymentMethod: selectedPaymentMethod),
    );
  }
}
