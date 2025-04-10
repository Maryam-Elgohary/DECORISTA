import 'package:flutter/material.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_average_rate.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/cubit/product_details_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class product_details_description_rate_row extends StatelessWidget {
  const product_details_description_rate_row({
    super.key,
    required this.cubit,
  });

  final ProductDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xffAB886D),
          ),
        ),
        product_details_average_rate(cubit: cubit),
      ],
    );
  }
}
