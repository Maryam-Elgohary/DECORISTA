import 'package:flutter/material.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';

class success_payment_text extends StatelessWidget {
  const success_payment_text({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Your order have been placed successfully! ",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xff828A89),
        fontSize: pxToSp(context, 20),
      ),
    );
  }
}
