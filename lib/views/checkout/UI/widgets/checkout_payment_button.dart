import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paymob_egypt/flutter_paymob_egypt.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/navigate_to.dart';
import 'package:furniture_app/core/sensetive_data.dart';
import 'package:furniture_app/views/checkout/UI/success_payment.dart';
import 'package:google_fonts/google_fonts.dart';

class checkout_payment_button extends StatelessWidget {
  const checkout_payment_button({
    super.key,
    required this.selectedPaymentMethod,
    required this.totalPayment,
  });

  final int selectedPaymentMethod;
  final double totalPayment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkBrown, // Change this color if needed
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          if (selectedPaymentMethod == 0) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => FlutterPaymobPayment(
                cardInfo: CardInfo(
                  apiKey:
                      paymobApiKey, // from dashboard Select Settings -> Account Info -> API Key
                  iframesID:
                      iframeId, // from paymob Select Developers -> iframes
                  integrationID:
                      integrationCardId, // from dashboard Select Developers -> Payment Integrations -> Online Card ID
                ),
                totalPrice: totalPayment, // required pay with Egypt currency
                appBar: null, // optional
                loadingIndicator: null, // optional
                billingData: null, // optional => your data
                items: const [], // optional
                successResult: (data) {
                  log('successResult: $data');
                  naviagteTo(context, SuccessPayment());
                },
                errorResult: (error) {
                  log('errorResult: $error');
                },
              ),
            ));
          }
        },
        child: Text(
          "Payment",
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
