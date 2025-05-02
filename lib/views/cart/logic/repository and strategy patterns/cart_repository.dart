// cart_repository.dart
import 'package:furniture_app/core/functions/api_services.dart';

abstract class CartRepository {
  Future<List<Map<String, dynamic>>> getCartItems(String userId);
  Future<void> addToCart(String userId, String productId, int quantity);
  Future<void> removeFromCart(String userId, String productId);
  Future<void> removeAllFromCart(String userId);
  Future<void> updateQuantity(String userId, String productId, int newQuantity);
}
