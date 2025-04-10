import 'package:flutter/material.dart';
import 'package:furniture_app/views/products_details/UI/product_details.dart';

class product_details_image extends StatelessWidget {
  const product_details_image({
    super.key,
    required this.colorToImage,
    required Color? selectedColor,
    required this.widget,
    required this.imageWidth,
    required this.imageHeight,
  }) : _selectedColor = selectedColor;

  final Map<Color, String> colorToImage;
  final Color? _selectedColor;
  final ProductDetails widget;
  final double imageWidth;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        child: Image.network(
          colorToImage[_selectedColor] ??
              (widget.product.productImageTable.isNotEmpty
                  ? widget.product.productImageTable.first.imageUrl
                  : 'https://via.placeholder.com/150'),
          fit: BoxFit.fill,
          width: imageWidth,
          height: imageHeight,
        ),
      ),
    );
  }
}
