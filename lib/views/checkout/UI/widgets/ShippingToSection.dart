import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingToSection extends StatelessWidget {
  final List<Map<String, String>> addresses;
  final Function(int)? onEditPressed;

  const ShippingToSection({
    super.key,
    required this.addresses,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
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
                        style: const TextStyle(color: Color(0xff828A89)),
                      ),
                      Text(
                        addresses[index]["street"]!,
                        style: const TextStyle(color: Color(0xff828A89)),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.grey),
                    onPressed: onEditPressed != null
                        ? () => onEditPressed!(index)
                        : null,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
