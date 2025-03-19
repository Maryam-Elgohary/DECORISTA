import 'dart:convert';

import 'package:furniture_app/core/models/category.dart';
import 'package:furniture_app/core/models/product_image.dart';

import 'favorite_products.dart';

List<Products> productsFromJson(String str) =>
    List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
  String productId;
  DateTime createdAt;
  String productName;
  int price;
  String description;
  String categoryId;
  CategoryTable categoryTable;
  List<ProductImageTable> productImageTable;
  List<FavoriteTable> favoriteTable;

  Products({
    required this.productId,
    required this.createdAt,
    required this.productName,
    required this.price,
    required this.description,
    required this.categoryId,
    required this.categoryTable,
    required this.productImageTable,
    required this.favoriteTable,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        productId: json["product_id"],
        createdAt: DateTime.parse(json["created_at"]),
        productName: json["product_name"],
        price: json["price"],
        description: json["description"],
        categoryId: json["category_id"],
        categoryTable: CategoryTable.fromJson(json["category_table"]),
        productImageTable: List<ProductImageTable>.from(
            json["product_image_table"]
                .map((x) => ProductImageTable.fromJson(x))),
        favoriteTable: List<FavoriteTable>.from(
            json["favorite_table"].map((x) => FavoriteTable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "created_at": createdAt.toIso8601String(),
        "product_name": productName,
        "price": price,
        "description": description,
        "category_id": categoryId,
        "category_table": categoryTable.toJson(),
        "product_image_table":
            List<dynamic>.from(productImageTable.map((x) => x.toJson())),
        "favorite_table":
            List<dynamic>.from(favoriteTable.map((x) => x.toJson())),
      };
}
