import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/navigate_to.dart';
import 'package:furniture_app/views/checkout/UI/check_out.dart';
import 'package:google_fonts/google_fonts.dart';

class bottomsheet_container extends StatelessWidget {
  const bottomsheet_container({
    super.key,
    required this.subtotal,
    required this.shippingCost,
  });

  final double subtotal;
  final double shippingCost;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      "\$${subtotal.toStringAsFixed(2)}",
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
                      "\$${shippingCost}",
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
                      "\$${(subtotal + shippingCost).toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: AppColors.orangeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
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
                  naviagteTo(
                      context,
                      CheckOut(
                        subtotal: subtotal,
                        shippingCost: shippingCost,
                      ));
                },
                child: Text(
                  "Check Out",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
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
}
