// product_repository.dart
import 'package:furniture_app/core/functions/api_services.dart';
import 'package:furniture_app/views/products_details/logic/model/rate_model.dart';

abstract class ProductRepository {
  Future<List<Rate>> getRates(String productId);
  Future<void> updateRate(String productId, Map<String, dynamic> data);
  Future<void> addRate(String productId, Map<String, dynamic> data);
  Future<void> addComment(Map<String, dynamic> data);
}

class SupabaseProductRepository implements ProductRepository {
  final ApiServices _apiServices;
  final String userId;

  SupabaseProductRepository(this._apiServices, this.userId);

  @override
  Future<List<Rate>> getRates(String productId) async {
    final response = await _apiServices
        .getData("rating_table?select=*&product_id=eq.$productId");
    return response.data.map<Rate>((rate) => Rate.fromJson(rate)).toList();
  }

  @override
  Future<void> updateRate(String productId, Map<String, dynamic> data) async {
    final path =
        "rating_table?select=*&user_id=eq.$userId&product_id=eq.$productId";
    await _apiServices.patchData(path, data);
  }

  @override
  Future<void> addRate(String productId, Map<String, dynamic> data) async {
    final path =
        "rating_table?select=*&user_id=eq.$userId&product_id=eq.$productId";
    await _apiServices.postData(path, data);
  }

  @override
  Future<void> addComment(Map<String, dynamic> data) async {
    await _apiServices.postData("review_table", data);
  }
}
