import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomActionSection extends StatelessWidget {
  const BottomActionSection({
    required this.product,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
    required this.onAddToCart,
    required this.isLoading,
  });

  final Products product;
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final VoidCallback onAddToCart;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.22,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: onDecrease,
                    icon: const Icon(Icons.remove, color: AppColors.darkBrown),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 219, 219, 221),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    quantity.toString().padLeft(2, '0'),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
              ),
              Text(
                '\$${(product.discountedPrice * quantity).toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  color: AppColors.darkBrown,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: isLoading ? null : onAddToCart,
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            label: Text(
              'Add To Cart',
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkBrown,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
