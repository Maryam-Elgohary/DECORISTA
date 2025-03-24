import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paymob_egypt/flutter_paymob_egypt.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/build_appbar.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/core/sensetive_data.dart';
import 'package:furniture_app/views/checkout/UI/success_payment.dart';
import 'package:furniture_app/views/checkout/widgets/build_payment_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CheckOut extends StatefulWidget {
  final double subtotal;
  final double shippingCost;

  const CheckOut({
    super.key,
    required this.subtotal,
    required this.shippingCost,
  });

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  int selectedAddressIndex = 0;
  int selectedPaymentMethod = 0;
  int _discountPercentage = 0;
  final TextEditingController _promoCodeController = TextEditingController();

  final List<Map<String, String>> addresses = [
    {
      "title": "Home Address",
      "phone": "(269) 444-6853",
      "street": "Road Number"
    },
  ];

  final List<Map<String, String>> paymentMethods = [
    {"title": "Credit Card", "icon": "assets/credit_card.png"},
    {"title": "Paypal", "icon": "assets/paypal.png"},
    {"title": "Apple Pay", "icon": "assets/apple_pay.png"},
  ];

  Future<void> _fetchDiscount(String promocode) async {
    try {
      final response = await Supabase.instance.client
          .from('offers_table')
          .select('discount_percentage')
          .eq('promocode', promocode)
          .single();

      if (response != null) {
        setState(() {
          _discountPercentage = response['discount_percentage'];
        });
      } else {
        _resetDiscount();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid Promocode!")),
        );
      }
    } catch (e) {
      _resetDiscount();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error applying promocode")),
      );
    }
  }

  void _resetDiscount() {
    setState(() {
      _discountPercentage = 0;
    });
  }

  double get totalPayment {
    return ((widget.subtotal + widget.shippingCost) *
        (1 - _discountPercentage / 100));
  }

  void _handlePayment() {
    if (selectedPaymentMethod != 0) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FlutterPaymobPayment(
          cardInfo: CardInfo(
            apiKey: paymobApiKey,
            iframesID: iframeId,
            integrationID: integrationCardId,
          ),
          totalPrice: totalPayment,
          appBar: null,
          loadingIndicator: null,
          billingData: null,
          items: const [],
          successResult: (data) {
            log('successResult: $data');
            naviagteTo(context, SuccessPayment());
          },
          errorResult: (error) {
            log('errorResult: $error');
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: buildCustomAppBar(context, "Checkout"),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 150),
              child: Column(
                children: [
                  _buildShippingSection(),
                  const SizedBox(height: 20),
                  _buildPaymentMethodSection(),
                  const SizedBox(height: 20),
                  _buildPromoCodeSection(),
                ],
              ),
            ),
          ),
          _buildOrderSummary(),
        ],
      ),
    );
  }

  Widget _buildShippingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Shipping To",
            style: GoogleFonts.poppins(
              color: AppColors.darkBrown,
              fontWeight: FontWeight.w600,
              fontSize: pxToSp(context, 20),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children:
                addresses.map((address) => _buildAddressCard(address)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(Map<String, String> address) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 5),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          address["title"]!,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              address["phone"]!,
              style: const TextStyle(color: Color(0xff828A89)),
            ),
            Text(
              address["street"]!,
              style: const TextStyle(color: Color(0xff828A89)),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.grey),
          onPressed: () {
            // Handle edit address
          },
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
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
                children: paymentMethods
                    .asMap()
                    .entries
                    .map((entry) =>
                        buildPaymentMethodTile(entry.key, entry.value))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPaymentMethodTile(int index, Map<String, String> method) {
    return ListTile(
      leading: Image.asset(
        method["icon"]!,
        width: 40,
        height: 40,
      ),
      title: Text(
        method["title"]!,
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
  }

  Widget _buildPromoCodeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Promo Code",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _promoCodeController,
            decoration: InputDecoration(
              hintText: "Promo code",
              hintStyle: GoogleFonts.poppins(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 6, top: 6, bottom: 6),
                child: ElevatedButton(
                  onPressed: () => _fetchDiscount(_promoCodeController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBrown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: Text(
                    "Apply",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order Summary",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.darkBrown,
            ),
          ),
          const SizedBox(height: 10),
          _buildOrderSummaryRow("Subtotal", widget.subtotal.toStringAsFixed(2)),
          const SizedBox(height: 5),
          _buildOrderSummaryRow(
              "Shipping Cost", widget.shippingCost.toString()),
          const SizedBox(height: 5),
          const Divider(color: Color(0xfff0f0f2)),
          const SizedBox(height: 5),
          _buildTotalPaymentRow(),
          const SizedBox(height: 5),
          buildPaymentButton(_handlePayment),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style:
              GoogleFonts.poppins(fontSize: 16, color: const Color(0xff828A89)),
        ),
        Text(
          "\$$value",
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: AppColors.orangeColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalPaymentRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Total Payment",
          style: GoogleFonts.poppins(
            color: AppColors.darkBrown,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "\$${totalPayment.toStringAsFixed(2)}",
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: AppColors.orangeColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
