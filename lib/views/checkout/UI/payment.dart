import 'package:flutter/material.dart';
import 'package:furniture_app/core/functions/stripe_service.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String amount = '5000';
  String currency = 'EGP';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Stripe Payment")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await StripeService.initPaymentSheet(amount, currency);
                      await StripeService.presentPaymentSheet();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: ${e.toString()}")));
                    }
                  },
                  child: Text("Pay \$50"))
            ],
          ),
        ));
  }
}
