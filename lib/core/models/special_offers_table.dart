// To parse this JSON data, do
//
//     final specialOffersTable = specialOffersTableFromJson(jsonString);

import 'dart:convert';

SpecialOffersTable specialOffersTableFromJson(String str) =>
    SpecialOffersTable.fromJson(json.decode(str));

String specialOffersTableToJson(SpecialOffersTable data) =>
    json.encode(data.toJson());

class SpecialOffersTable {
  int id;
  int discount;
  DateTime createdAt;
  String productId;

  SpecialOffersTable({
    required this.id,
    required this.discount,
    required this.createdAt,
    required this.productId,
  });

  factory SpecialOffersTable.fromJson(Map<String, dynamic> json) =>
      SpecialOffersTable(
        id: json["id"],
        discount: json["discount"],
        createdAt: DateTime.parse(json["created_at"]),
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "discount": discount,
        "created_at": createdAt.toIso8601String(),
        "product_id": productId,
      };
}
