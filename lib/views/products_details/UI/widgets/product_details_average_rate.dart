import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/cubit/product_details_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class product_details_average_rate extends StatelessWidget {
  const product_details_average_rate({
    super.key,
    required this.cubit,
  });

  final ProductDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 25),
        SizedBox(width: 4),
        Text(
          "${cubit.averageRate}",
          style: GoogleFonts.poppins(
              color: AppColors.darkBrown,
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
