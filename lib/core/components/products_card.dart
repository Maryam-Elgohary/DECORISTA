import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/models/favorite_products.dart';
import 'package:furniture_app/core/models/product_model.dart';

class ProductsCard extends StatefulWidget {
  ProductsCard({super.key, required this.product});
  final Products product;
  @override
  _ProductsCardState createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.product.favoriteTable
        .cast<FavoriteTable>() // Ensures the list is properly typed
        .any((fav) => fav.isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    // Use network image instead of asset
                    widget.product.productImageTable.isNotEmpty
                        ? widget.product.productImageTable.first.imageUrl
                        : 'https://via.placeholder.com/150', // Placeholder if no image
                    height: 190,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                  },
                  child: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: Text(
                    widget.product.productName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.darkBrown,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${widget.product.price}", // Fixed property access
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.orangeColor,
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.darkBrown),
                          borderRadius: BorderRadius.circular(10)),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_rounded,
                          size: 27,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(
                            minWidth: 35, minHeight: 35), // Ensures proper size
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
