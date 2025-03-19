class FavoriteTable {
  DateTime createdAt;
  String productId;
  String customerId;
  String favoriteId;
  bool isFavorite;

  FavoriteTable({
    required this.createdAt,
    required this.productId,
    required this.customerId,
    required this.favoriteId,
    required this.isFavorite,
  });

  factory FavoriteTable.fromJson(Map<String, dynamic> json) => FavoriteTable(
        createdAt: DateTime.parse(json["created_at"]),
        productId: json["product_id"],
        customerId: json["customer_id"],
        favoriteId: json["favorite_id"],
        isFavorite: json["is_favorite"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "product_id": productId,
        "customer_id": customerId,
        "favorite_id": favoriteId,
        "is_favorite": isFavorite,
      };
}
