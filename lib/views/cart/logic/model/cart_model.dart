// ignore_for_file: public_member_api_docs, sort_constructors_first

class CartItem {
  String cartId;
  String productId;
  String customerId;
  int quantity;
  DateTime createdAt;

  CartItem({
    required this.cartId,
    required this.productId,
    required this.customerId,
    required this.quantity,
    required this.createdAt,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartId: json['cart_id'],
      productId: json['product_id'],
      customerId: json['customer_id'],
      quantity: json['quantity'],
      createdAt: json["created_at"] != null
          ? DateTime.tryParse(json["created_at"]) ?? DateTime.now()
          : DateTime.now(),
    );
  }
  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "product_id": productId,
        "customer_id": customerId,
        "cart_id": cartId,
        "quantity": quantity,
      };
}
