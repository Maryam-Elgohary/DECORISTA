import 'package:flutter/material.dart';
import 'package:furniture_app/views/products_details/UI/product_details.dart';
import 'package:google_fonts/google_fonts.dart';

class product_details_description_part extends StatelessWidget {
  const product_details_description_part({
    super.key,
    required this.widget,
  });

  final ProductDetails widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Text(
        "${widget.product.description}",
        style: GoogleFonts.poppins(fontSize: 18, color: Color(0xffAB886D)),
      ),
    );
  }
}
