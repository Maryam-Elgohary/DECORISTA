import 'package:flutter/material.dart';
import 'package:furniture_app/views/checkout/widgets/BackToHomeButton.dart';
import 'package:furniture_app/views/checkout/widgets/OrderConfirmationMessage.dart';
import 'package:furniture_app/views/checkout/widgets/SuccessIcon.dart';
import 'package:furniture_app/views/checkout/widgets/ThankYouMessage.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';

class PaymentSuccessContent extends StatelessWidget {
  final UserDataModel? userDataModel;

  const PaymentSuccessContent({required this.userDataModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SuccessIcon(),
            const SizedBox(height: 25),
            const ThankYouMessage(),
            const SizedBox(height: 15),
            const OrderConfirmationMessage(),
            const SizedBox(height: 25),
            BackToHomeButton(userDataModel: userDataModel),
          ],
        ),
      ),
    );
  }
}
