import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/build_appbar.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/functions/supabase_manager.dart';
import 'package:furniture_app/views/checkout/UI/widgets/checkout_bottom_sheet.dart';
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

  List<Map<String, String>> addresses = [
    {
      "title": "Home Address",
      "phone": "(269) 444-6853",
      "street": "Road Number"
    },
  ];

  List<Map<String, String>> paymentMethods = [
    {"title": "Credit Card", "icon": "assets/credit_card.png"},
    {"title": "Paypal", "icon": "assets/paypal.png"},
    {"title": "Apple Pay", "icon": "assets/apple_pay.png"},
  ];
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
          checkout_shipping_to(context),
          const SizedBox(height: 20),
          checkout_payment_methods(),
          const SizedBox(height: 20),
          checkout_promocode(_promoCodeController, totalPayment),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Padding checkout_shipping_to(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Shipping To",
              style: GoogleFonts.poppins(
                  color: AppColors.darkBrown,
                  fontWeight: FontWeight.w600,
                  fontSize: pxToSp(context, 20))),
          const SizedBox(height: 10),
          Column(
            children: List.generate(addresses.length, (index) {
              return Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 5),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    addresses[index]["title"]!,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        addresses[index]["phone"]!,
                        style: TextStyle(color: Color(0xff828A89)),
                      ),
                      Text(addresses[index]["street"]!,
                          style: TextStyle(color: Color(0xff828A89))),
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
            }),
          ),
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

  Padding checkout_promocode(
      TextEditingController _promoCodeController, double totalPayment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Promo Code",
            style: GoogleFonts.poppins(
              fontSize: 16, // Replace pxToSp(context, 20) if needed
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
                  borderSide: BorderSide.none),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 6, top: 6, bottom: 6),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _fetchDiscount(_promoCodeController.text);
                      totalPayment;
                    });
                  },
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
        ],
      ),
    );
  }
}
