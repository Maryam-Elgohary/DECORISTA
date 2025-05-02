import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// A widget for controlling product quantity with increment and decrement buttons.
class QuantityControls extends StatelessWidget {
  const QuantityControls({
    super.key,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onDecrease,
          icon: Icon(Icons.remove, color: AppColors.darkBrown),
          style: IconButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 219, 219, 221),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          quantity.toString().padLeft(2, '0'),
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        IconButton(
          onPressed: onIncrease,
          icon: const Icon(Icons.add, color: Colors.white),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.darkBrown,
          ),
        ),
      ],
    );
  }
}
