import 'package:flutter/material.dart';
import 'package:furniture_app/core/components/products_card.dart';

class ProductsList extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      "name": "Modern Wooden Chair",
      "price": 258.91,
      "image": "assets/ModernWoodenChair.png",
      "isFavorite": false,
    },
    {
      "name": "Ergonomic Office Chair",
      "price": 279.95,
      "image": "assets/ErgonomicOfficeChair.png",
      "isFavorite": false,
    },
    {
      "name": "Royal Chair",
      "price": 290.95,
      "image": "assets/RoyalChair.png",
      "isFavorite": false,
    },
    {
      "name": "Rocking Chair",
      "price": 369.86,
      "image": "assets/RockingChair.png",
      "isFavorite": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductsCard(
          name: product["name"],
          price: product["price"],
          image: product["image"],
          isFavorite: product["isFavorite"],
        );
      },
    );
  }
}
