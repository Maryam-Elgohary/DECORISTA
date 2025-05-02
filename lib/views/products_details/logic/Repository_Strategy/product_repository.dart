// product_repository.dart
import 'package:furniture_app/core/functions/api_services.dart';
import 'package:furniture_app/views/products_details/logic/model/rate_model.dart';

abstract class ProductRepository {
  Future<List<Rate>> getRates(String productId);
  Future<void> updateRate(String productId, Map<String, dynamic> data);
  Future<void> addRate(String productId, Map<String, dynamic> data);
  Future<void> addComment(Map<String, dynamic> data);
}
