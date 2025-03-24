import 'package:furniture_app/core/models/product_model.dart';

double calculateSubtotal(List<Products> products) {
  return products.fold(0.0, (sum, item) {
    double price = item.price.toDouble();
    if (item.specialOffersTable.isNotEmpty) {
      final discount = item.specialOffersTable.first.discount.toDouble();
      if (discount > 0 && discount <= 100) {
        price *= (100 - discount) / 100;
      }
    }
    return sum + (price * (item.quantity ?? 1));
  });
}
