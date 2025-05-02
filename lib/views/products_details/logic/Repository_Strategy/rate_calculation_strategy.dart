// rate_calculation_strategy.dart
import 'package:furniture_app/views/products_details/logic/model/rate_model.dart';

abstract class RateCalculationStrategy {
  int calculateAverage(List<Rate> rates);
  int getUserRate(List<Rate> rates, String userId);
  bool userRateExists(List<Rate> rates, String userId, String productId);
}
