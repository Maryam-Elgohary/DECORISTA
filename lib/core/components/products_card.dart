import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/products/UI/product_details.dart';

class ProductsCard extends StatefulWidget {
  const ProductsCard({
    super.key,
    required this.product,
    this.onTap,
    required this.isFavorite,
    this.discount = 0,
  });

  final Products product;
  final Function()? onTap;
  final bool isFavorite;
  final int discount;

  @override
  _ProductsCardState createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth * 0.4; // Consistent image height
    final textSize = screenWidth * 0.045;
    final iconSize = screenWidth * 0.06;
    final buttonSize = screenWidth * 0.1;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          clipBehavior:
              Clip.antiAlias, // Prevents content from bleeding outside
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              maxWidth: constraints.maxWidth,
              minHeight: 0, // Let content determine height
              maxHeight: double.infinity,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image section
                  AspectRatio(
                    aspectRatio: 1, // Square aspect ratio
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.product.productImageTable.isNotEmpty
                                ? widget
                                    .product.productImageTable.first.imageUrl
                                : 'https://via.placeholder.com/150',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.image_not_supported),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: widget.onTap,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                widget.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: widget.isFavorite
                                    ? Colors.red
                                    : Colors.grey,
                                size: iconSize * 0.8,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Product name (with fixed max lines)
                  SizedBox(
                    height: textSize * 2.4, // Enough for 2 lines of text
                    child: Text(
                      widget.product.productName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: textSize,
                        color: AppColors.darkBrown,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Price and button row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Price column
                      widget.product.hasDiscount
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "\$${widget.product.price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    decoration: TextDecoration.lineThrough,
                                    color: AppColors.lightBrown,
                                  ),
                                ),
                                Text(
                                  "\$${widget.product.discountedPrice.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.orangeColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Text(
                                  "\$${widget.product.price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.orangeColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                      // Arrow button
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
                              context,
                              ProductDetails(
                                product: widget.product,
                                isFav: widget.isFavorite,
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.arrow_forward_rounded,
                            size: iconSize,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
