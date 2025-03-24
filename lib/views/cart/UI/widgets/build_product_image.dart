import 'package:flutter/material.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/cart/UI/widgets/build_placeholder_image.dart';

Widget buildProductImage(Products item) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: item.productImageTable.isNotEmpty
        ? Image.network(
            item.productImageTable.first.imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => buildPlaceholderImage(),
          )
        : buildPlaceholderImage(),
  );
}
