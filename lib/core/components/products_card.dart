import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/products/UI/product_details.dart';

class ProductsCard extends StatefulWidget {
  const ProductsCard(
      {super.key, required this.product, this.onTap, required this.isFavorite});

  final Products product;
  final Function()? onTap;
  final bool isFavorite;
  @override
  _ProductsCardState createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  //late bool _isFavorite;

  // @override
  // void initState() {
  //   super.initState();
  //   _isFavorite = widget.product.favoriteTable
  //       .cast<FavoriteTable>()
  //       .any((fav) => fav.isFavorite);
  // }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double imageHeight = screenWidth * 0.4; // Adjusted for balance
    final double textSize = screenWidth * 0.045; // Responsive text size
    final double iconSize = screenWidth * 0.06; // Responsive icon size
    final double buttonSize = screenWidth * 0.1; // Adjusted button size

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(10.0), // Added padding for better spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Prevent unnecessary extra height
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.product.productImageTable.isNotEmpty
                        ? widget.product.productImageTable.first.imageUrl
                        : 'https://via.placeholder.com/150',
                    height: imageHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: widget.onTap,
                    child: Icon(
                      widget.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.isFavorite ? Colors.red : Colors.grey,
                      size: iconSize,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8), // Space after image
            Text(
              widget.product.productName,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: textSize,
                color: AppColors.darkBrown,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6), // Space before price & button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${widget.product.price}",
                  style: TextStyle(
                    fontSize: textSize,
                    color: AppColors.orangeColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: buttonSize,
                  height: buttonSize,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.darkBrown),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () {
                      naviagteTo(
                          context, ProductDetails(product: widget.product));
                    },
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      size: iconSize,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
