class Rate {
  String? rating_id;
  DateTime? createdAt;
  int? rate;
  String? user_id;
  String? product_id;

  Rate(
      {this.rating_id,
      this.createdAt,
      this.rate,
      this.user_id,
      this.product_id});

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        rating_id: json['rating_id'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        rate: json['rate'] as int?,
        user_id: json['user_id'] as String?,
        product_id: json['product_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'rating_id': rating_id,
        'created_at': createdAt?.toIso8601String(),
        'rate': rate,
        'user_id': user_id,
        'product_id': product_id,
      };
}
