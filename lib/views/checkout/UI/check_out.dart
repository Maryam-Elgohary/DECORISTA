import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/build_appbar.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/functions/supabase_manager.dart';
import 'package:furniture_app/views/checkout/UI/widgets/PromoCodeField.dart';
import 'package:furniture_app/views/checkout/UI/widgets/ShippingToSection.dart';
import 'package:furniture_app/views/checkout/UI/widgets/address_data.dart';
import 'package:furniture_app/views/checkout/UI/widgets/checkout_bottom_sheet.dart';
import 'package:furniture_app/views/checkout/UI/widgets/payment_methods_data.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckOut extends StatefulWidget {
  CheckOut({
    super.key,
    required this.subtotal,
    required this.shippingCost,
  });
  double subtotal;
  double shippingCost;

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  int selectedAddressIndex = 0;
  int selectedPaymentMethod = 0;

  int _discountPercentage = 0; // Start with no discount

  Future<void> _fetchDiscount(String promocode) async {
    final response = await SupabaseManager()
        .client
        .from('offers_table')
        .select('discount_percentage')
        .eq('promocode', promocode)
        .single();

    if (response != null) {
      setState(() {
        _discountPercentage = response['discount_percentage'];
      });
    } else {
      setState(() {
        _discountPercentage = 0; // Reset if promocode is invalid
      });
      // Optionally, show a message to the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Invalid Promocode!"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPayment = ((widget.subtotal + widget.shippingCost) *
        (1 - _discountPercentage / 100));

    TextEditingController _promoCodeController = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: buildCustomAppBar(context, "Checkout"),
      body: checout_body(context, _promoCodeController, totalPayment),
      bottomSheet: checkout_bottom_sheet(
          widget: widget,
          totalPayment: totalPayment,
          selectedPaymentMethod: selectedPaymentMethod),
    );
  }

  SingleChildScrollView checout_body(BuildContext context,
      TextEditingController _promoCodeController, double totalPayment) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.35),
      child: Column(
        children: [
          ShippingToSection(
            addresses: addresses,
            onEditPressed: (index) {
              // Handle edit address action
            },
          ),
          const SizedBox(height: 20),
          checkout_payment_methods(),
          const SizedBox(height: 20),
          PromoCodeField(
            controller: _promoCodeController,
            onApplyPressed: () {
              String promoCode = _promoCodeController.text;
              if (promoCode.isNotEmpty) {
                _fetchDiscount(promoCode);
              }
            },
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Padding checkout_payment_methods() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Method",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: List.generate(paymentMethods.length, (index) {
                  return ListTile(
                    leading: Image.asset(
                      paymentMethods[index]["icon"]!,
                      width: 40,
                      height: 40,
                    ),
                    title: Text(
                      paymentMethods[index]["title"]!,
                      style: GoogleFonts.poppins(),
                    ),
                    trailing: Radio<int>(
                      value: index,
                      groupValue: selectedPaymentMethod,
                      activeColor: Colors.brown,
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentMethod = value!;
                        });
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
