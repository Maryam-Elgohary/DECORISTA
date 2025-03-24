import 'package:flutter/material.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/cart/UI/widgets/build_cart_item.dart';

Widget buildProductList(List<Products> products) {
  if (products.isEmpty) {
    return const Center(child: Text('Your cart is empty'));
  }

  return ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: products.length,
    itemBuilder: (context, index) => buildCartItem(products[index], context),
  );
}
