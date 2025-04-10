import 'package:flutter/material.dart';
import 'package:furniture_app/views/checkout/UI/widgets/Success_payment_thank_text.dart';
import 'package:furniture_app/views/checkout/UI/widgets/success_payment_back_home_button.dart';
import 'package:furniture_app/views/checkout/UI/widgets/success_payment_circle_avatar.dart';
import 'package:furniture_app/views/checkout/UI/widgets/success_payment_text.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';

class success_payment_body extends StatelessWidget {
  const success_payment_body({
    super.key,
    required this.userDataModel,
  });

  final UserDataModel? userDataModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            success_payment_circle_avatar(),
            const SizedBox(height: 25),
            Success_payment_thank_text(),
            const SizedBox(height: 15),
            success_payment_text(),
            const SizedBox(height: 25),
            success_payment_back_home_button(userDataModel: userDataModel),
          ],
        ),
      ),
    );
  }
}
