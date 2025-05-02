
import 'package:furniture_app/core/functions/api_services.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cart_repository.dart';

class SupabaseCartRepository implements CartRepository {
  final ApiServices _apiServices;

  SupabaseCartRepository(this._apiServices);

  @override
  Future<List<Map<String, dynamic>>> getCartItems(String userId) async {
    final response = await _apiServices.getData(
        "cart_table?select=*,product_id(*,category_table(*),product_image_table(*),special_offers_table(*))&customer_id=eq.${_encode(userId)}");
    return List<Map<String, dynamic>>.from(response.data);
  }

  @override
  Future<void> addToCart(String userId, String productId, int quantity) async {
    await _apiServices.postData("cart_table",
        {"customer_id": userId, "product_id": productId, "quantity": quantity});
  }

  @override
  Future<void> removeFromCart(String userId, String productId) async {
    await _apiServices.deleteData(
        "cart_table?customer_id=eq.${_encode(userId)}&product_id=eq.${_encode(productId)}");
  }

  @override
  Future<void> removeAllFromCart(String userId) async {
    await _apiServices
        .deleteData("cart_table?customer_id=eq.${_encode(userId)}");
  }

  @override
  Future<void> updateQuantity(
      String userId, String productId, int newQuantity) async {
    await _apiServices.patchData(
      "cart_table?customer_id=eq.${_encode(userId)}&product_id=eq.${_encode(productId)}",
      {"quantity": newQuantity},
    );
  }

  String _encode(String value) => Uri.encodeComponent(value);
}
