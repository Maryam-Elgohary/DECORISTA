//factory design pattern

class Rate {
  final String? ratingId;
  final DateTime? createdAt;
  final int? rate;
  final String? userId;
  final String? productId;

  Rate({
    this.ratingId,
    this.createdAt,
    this.rate,
    this.userId,
    this.productId,
  });

  factory Rate.fromJson(Map<String, dynamic> json) {
    try {
      return Rate(
        ratingId: json['rating_id'] as String?,
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'] as String)
            : null,
        rate: json['rate'] != null ? (json['rate'] as num).toInt() : null,
        userId: json['user_id'] as String?,
        productId: json['product_id'] as String?,
      );
    } catch (e) {
      throw const FormatException('Invalid JSON format for Rate');
    }
  }

  Map<String, dynamic> toJson() => {
        'rating_id': ratingId,
        'created_at': createdAt?.toIso8601String(),
        'rate': rate,
        'user_id': userId,
        'product_id': productId,
      };

  Rate copyWith({
    String? ratingId,
    DateTime? createdAt,
    int? rate,
    String? userId,
    String? productId,
  }) {
    return Rate(
      ratingId: ratingId ?? this.ratingId,
      createdAt: createdAt ?? this.createdAt,
      rate: rate ?? this.rate,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
    );
  }

  @override
  String toString() {
    return 'Rate(ratingId: $ratingId, createdAt: $createdAt, rate: $rate, '
        'userId: $userId, productId: $productId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Rate &&
        other.ratingId == ratingId &&
        other.createdAt == createdAt &&
        other.rate == rate &&
        other.userId == userId &&
        other.productId == productId;
  }

  @override
  int get hashCode {
    return ratingId.hashCode ^
        createdAt.hashCode ^
        rate.hashCode ^
        userId.hashCode ^
        productId.hashCode;
  }
}
