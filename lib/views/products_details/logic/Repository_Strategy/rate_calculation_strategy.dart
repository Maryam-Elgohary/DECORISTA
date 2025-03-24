// rate_calculation_strategy.dart
import 'package:furniture_app/views/products_details/logic/model/rate_model.dart';

abstract class RateCalculationStrategy {
  int calculateAverage(List<Rate> rates);
  int getUserRate(List<Rate> rates, String userId);
  bool userRateExists(List<Rate> rates, String userId, String productId);
}

class SimpleRateCalculation implements RateCalculationStrategy {
  @override
  int calculateAverage(List<Rate> rates) {
    final validRates = rates.where((rate) => rate.rate != null).toList();
    if (validRates.isEmpty) return 0;

    final sum = validRates.fold(0, (total, rate) => total + rate.rate!);
    return sum ~/ validRates.length;
  }

  @override
  int getUserRate(List<Rate> rates, String userId) {
    return rates
            .firstWhere(
              (rate) => rate.userId == userId,
              orElse: () => Rate(rate: 0),
            )
            .rate ??
        0;
  }

  @override
  bool userRateExists(List<Rate> rates, String userId, String productId) {
    return rates.any(
      (rate) => rate.userId == userId && rate.productId == productId,
    );
  }
}
