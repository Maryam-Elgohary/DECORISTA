import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/build_appbar.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    String totalPayment = ((widget.subtotal + widget.shippingCost) *
            (1 - _discountPercentage / 100))
        .toStringAsFixed(2);

    TextEditingController _promoCodeController = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: buildCustomAppBar(context, "Checkout"),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.35),
        child: Column(
          children: [
            Padding(
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
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600),
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
            ),
            const SizedBox(height: 20),
            Padding(
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
            ),
            const SizedBox(height: 20),
            Padding(
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
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      suffixIcon: Padding(
                        padding:
                            const EdgeInsets.only(right: 6, top: 6, bottom: 6),
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
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 0.35,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Subtotal",
                  style: GoogleFonts.poppins(
                      fontSize: 16, color: Color(0xff828A89)),
                ),
                Text(
                  "\$${widget.subtotal.toStringAsFixed(2)}",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppColors.orangeColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Shipping Cost",
                  style: GoogleFonts.poppins(
                      fontSize: 16, color: Color(0xff828A89)),
                ),
                Text(
                  "\$${widget.shippingCost}",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppColors.orangeColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Divider(
              color: Color(0xfff0f0f2),
            ),
            const SizedBox(height: 5),
            Row(
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
                  //  "\$${(widget.subtotal + widget.shippingCost).toStringAsFixed(2)}",
                  "\$${totalPayment}",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: AppColors.orangeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.darkBrown, // Change this color if needed
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Handle checkout action
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
            )
          ],
        ),
      ),
    );
  }
}
