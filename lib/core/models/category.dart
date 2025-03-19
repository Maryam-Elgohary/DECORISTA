class CategoryTable {
  String imageUrl;
  String categoryId;
  String categoryName;

  CategoryTable({
    required this.imageUrl,
    required this.categoryId,
    required this.categoryName,
  });

  factory CategoryTable.fromJson(Map<String, dynamic> json) => CategoryTable(
        imageUrl: json["image_url"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
        "category_id": categoryId,
        "category_name": categoryName,
      };
}
