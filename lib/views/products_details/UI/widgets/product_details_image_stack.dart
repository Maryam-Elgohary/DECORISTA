import 'package:flutter/material.dart';
import 'package:furniture_app/views/home/UI/cubit/cubit/home_cubit.dart';
import 'package:furniture_app/views/products_details/UI/product_details.dart';
import 'package:furniture_app/views/products_details/UI/widgets/color_selector.dart';
import 'package:furniture_app/views/products_details/UI/widgets/favorite_button.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_arrow_back.dart';
import 'package:furniture_app/views/products_details/UI/widgets/product_details_image.dart';

class ProductDetailsImageStack extends StatefulWidget {
  final ProductDetails widget;
  final HomeCubit homeCubit;
  final double iconSize;
  final Map<Color, String> colorToImage;
  final double imageWidth;
  final double imageHeight;

  const ProductDetailsImageStack({
    super.key,
    required this.widget,
    required this.homeCubit,
    required this.iconSize,
    required this.colorToImage,
    required this.imageWidth,
    required this.imageHeight,
  });

  @override
  _ProductDetailsImageStackState createState() =>
      _ProductDetailsImageStackState();
}

class _ProductDetailsImageStackState extends State<ProductDetailsImageStack> {
  Color _selectedColor = Colors.white; // Default color, adjust as needed
  bool _isFav = false; // Default favorite state

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        product_details_image(
          colorToImage: widget.colorToImage,
          selectedColor: _selectedColor,
          widget: widget.widget,
          imageWidth: widget.imageWidth,
          imageHeight: widget.imageHeight,
        ),
        product_details_arrow_back(),
        ColorSelector(
          colors: widget.colorToImage.keys.toList(),
          selectedColor: _selectedColor,
          onColorSelected: (color) {
            setState(() {
              _selectedColor = color;
            });
          },
        ),
        FavoriteButton(
          isFav: _isFav,
          iconSize: widget.iconSize,
          onPressed: () {
            setState(() {
              _isFav = !_isFav;
            });
            if (_isFav) {
              widget.homeCubit.addToFavorite(widget.widget.product.productId);
            } else {
              widget.homeCubit.removeFavorite(widget.widget.product.productId);
            }
          },
        ),
      ],
    );
  }
}
