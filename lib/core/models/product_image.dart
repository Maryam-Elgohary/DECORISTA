class ProductImageTable {
  String id;
  String color;
  String imageUrl;
  DateTime createdAt;
  String productId;

  ProductImageTable({
    required this.id,
    required this.color,
    required this.imageUrl,
    required this.createdAt,
    required this.productId,
  });

  factory ProductImageTable.fromJson(Map<String, dynamic> json) =>
      ProductImageTable(
        id: json["id"],
        color: json["color"],
        imageUrl: json["image_url"],
        createdAt: DateTime.parse(json["created_at"]),
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "color": color,
        "image_url": imageUrl,
        "created_at": createdAt.toIso8601String(),
        "product_id": productId,
      };
}
