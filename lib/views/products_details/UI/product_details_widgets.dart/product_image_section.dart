import 'package:flutter/material.dart';
import 'package:furniture_app/core/models/product_model.dart';

class ProductImageSection extends StatelessWidget {
  const ProductImageSection({
    required this.product,
    required this.colorToImage,
    required this.selectedColor,
    required this.isFav,
    required this.iconSize,
    required this.onColorChanged,
    required this.onFavoritePressed,
  });

  final Products product;
  final Map<Color, String> colorToImage;
  final Color? selectedColor;
  final bool isFav;
  final double iconSize;
  final ValueChanged<Color> onColorChanged;
  final VoidCallback onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height * 0.45,
      width: screenSize.width,
      child: Stack(
        children: [
          Center(
            child: ClipRRect(
              child: Image.network(
                colorToImage[selectedColor] ??
                    (product.productImageTable.isNotEmpty
                        ? product.productImageTable.first.imageUrl
                        : 'https://via.placeholder.com/150'),
                fit: BoxFit.fill,
                width: screenSize.width,
                height: screenSize.height * 0.45,
              ),
            ),
          ),
          // // Back Button
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: Align(
          //     alignment: Alignment.topLeft,
          //     child: IconButton(
          //       style: ButtonStyle(
          //         backgroundColor: WidgetStatePropertyAll(
          //           Colors.white.withOpacity(0.7),
          //         ),
          //       ),
          //       icon: const Icon(
          //         Icons.arrow_back,
          //         size: 25,
          //         color: AppColors.darkBrown,
          //       ),
          //       onPressed: () => Navigator.pop(context),
          //     ),
          //   ),
          // ),
          // Color Selector
          if (colorToImage.isNotEmpty)
            Positioned(
              right: 10,
              bottom: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: colorToImage.keys.map((color) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: GestureDetector(
                        onTap: () => onColorChanged(color),
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selectedColor == color
                                  ? const Color(0xff9C9C9C)
                                  : const Color(0xfff0f0f0),
                              width: 4,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          // Favorite Button
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: onFavoritePressed,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : Colors.grey,
                    size: iconSize,
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
