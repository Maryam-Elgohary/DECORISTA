import 'package:furniture_app/core/models/category.dart';
import 'package:furniture_app/core/models/favorite_products.dart';
import 'package:furniture_app/core/models/product_image.dart';
import 'package:furniture_app/core/models/special_offers_table.dart';
import 'package:furniture_app/views/cart/logic/model/cart_model.dart';

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
  List<CartItem> cartItem;
  int quantity; // Added field for quantity
  String brand;
  List<SpecialOffersTable> specialOffersTable;

  Products(
      {required this.productId,
      required this.createdAt,
      required this.productName,
      required this.price,
      required this.description,
      required this.categoryId,
      required this.categoryTable,
      required this.productImageTable,
      required this.favoriteTable,
      required this.cartItem,
      required this.quantity, // Added to constructor
      required this.brand,
      required this.specialOffersTable});

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        productId: json["product_id"],
        brand: json['brand'],
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"]) ?? DateTime.now()
            : DateTime.now(),
        productName: json["product_name"],
        price: json["price"],
        description: json["description"],
        categoryId: json["category_id"],
        categoryTable: json["category_table"] != null
            ? CategoryTable.fromJson(json["category_table"])
            : CategoryTable(categoryId: "", categoryName: "", imageUrl: ""),
        favoriteTable: json["favorite_table"] != null
            ? List<FavoriteTable>.from(
                json["favorite_table"].map((x) => FavoriteTable.fromJson(x)))
            : [],
        productImageTable: json["product_image_table"] != null
            ? List<ProductImageTable>.from(json["product_image_table"]
                .map((x) => ProductImageTable.fromJson(x)))
            : [],
        cartItem: json["cart_table"] != null
            ? List<CartItem>.from(
                (json["cart_table"] as List).map((x) => CartItem.fromJson(x)))
            : [],
        quantity:
            json["quantity"] ?? 1, // Ensure quantity is initialized properly

        specialOffersTable: json["special_offers_table"] != null
            ? List<SpecialOffersTable>.from(
                (json["special_offers_table"] as List)
                    .map((x) => SpecialOffersTable.fromJson(x)))
            : [],
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
        "cart_table": List<dynamic>.from(cartItem.map((x) => x.toJson())),
        "quantity": quantity, // Include quantity in the toJson method
        "special_offers_table":
            List<dynamic>.from(specialOffersTable.map((x) => x.toJson())),

        'brand': brand
      };
}

extension ProductExtensions on Products {
  bool get hasDiscount => specialOffersTable?.isNotEmpty ?? false;

  double get discountedPrice => hasDiscount
      ? price * (1 - (specialOffersTable!.first.discount / 100))
      : price.toDouble();

  int get discountPercentage =>
      hasDiscount ? specialOffersTable!.first.discount : 0;

  String get formattedOriginalPrice => "\$${price.toStringAsFixed(2)}";

  String get formattedDiscountedPrice =>
      "\$${discountedPrice.toStringAsFixed(2)}";
}
