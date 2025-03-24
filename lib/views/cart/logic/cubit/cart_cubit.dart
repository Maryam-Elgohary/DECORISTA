import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:furniture_app/core/functions/api_services.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/cart/logic/cubit/cart_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartCubit extends Cubit<CartState> {
  final SupabaseClient _supabase = Supabase.instance.client;
  final ApiServices _apiServices = ApiServices();

  List<Products> cartProducts = [];
  String? get userId => _supabase.auth.currentUser?.id;

  CartCubit() : super(CartInitial());

  // ================ Cart Operations ================ //

  Future<void> getCartProducts() async {
    emit(GetCartLoading());
    cartProducts.clear();

    if (userId == null) {
      _logError("User not authenticated");
      emit(GetCartError());
      return;
    }

    try {
      final response = await _apiServices.getData(
          "cart_table?select=*,product_id(*,category_table(*),product_image_table(*),special_offers_table(*))&customer_id=eq.$userId");

      _logDebug("Cart API Response: ${response.data}");

      if (response.data.isEmpty) {
        emit(GetCartSuccess());
        return;
      }

      for (final cartItem in response.data) {
        if (cartItem["product_id"] == null) continue;

        try {
          final productData = Map<String, dynamic>.from(cartItem["product_id"])
            ..['quantity'] = cartItem["quantity"] ?? 1;

          cartProducts.add(Products.fromJson(productData));
        } catch (e) {
          _logError("Error parsing product: $e");
        }
      }

      emit(GetCartSuccess());
    } catch (e) {
      _logError("Error fetching cart: $e");
      emit(GetCartError());
    }
  }

  Future<void> addToCart(String productId, int quantity) async {
    if (userId == null) return _handleAuthError();

    emit(AddToCartLoading());

    try {
      await _apiServices.postData("cart_table", {
        "customer_id": userId,
        "product_id": productId,
        "quantity": quantity
      });

      await getCartProducts();
      emit(AddToCartSuccess());
    } catch (e) {
      _logError("Add to cart failed: $e");
      emit(AddToCartError());
    }
  }

  Future<void> removeFromCart(String productId) async {
    if (userId == null) return _handleAuthError();

    emit(RemoveFromCartLoading());

    try {
      await _apiServices.deleteData(
          "cart_table?customer_id=eq.${_encode(userId!)}&product_id=eq.${_encode(productId)}");

      await getCartProducts();
      emit(RemoveFromCartSuccess());
    } catch (e) {
      _logError("Remove from cart failed: $e");
      emit(RemoveFromCartError());
    }
  }

  Future<void> removeAllFromCart() async {
    if (userId == null) return _handleAuthError();

    emit(RemoveAllFromCartLoading());

    try {
      await _apiServices
          .deleteData("cart_table?customer_id=eq.${_encode(userId!)}");

      await getCartProducts();
      emit(RemoveAllFromCartSuccess());
    } catch (e) {
      _logError("Remove all from cart failed: $e");
      emit(RemoveAllFromCartError());
    }
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    if (userId == null) return _handleAuthError();

    emit(UpdateQuantityLoading());

    final productIndex =
        cartProducts.indexWhere((p) => p.productId == productId);
    if (productIndex == -1) {
      emit(UpdateQuantityError());
      return;
    }

    final previousQuantity = cartProducts[productIndex].quantity ?? 1;
    cartProducts[productIndex].quantity = newQuantity;
    emit(CartUpdated());

    try {
      await _apiServices.patchData(
        "cart_table?customer_id=eq.${_encode(userId!)}&product_id=eq.${_encode(productId)}",
        {"quantity": newQuantity},
      );

      emit(UpdateQuantitySuccess());
    } catch (e) {
      _logError("Update quantity failed: $e");
      cartProducts[productIndex].quantity = previousQuantity;
      emit(CartUpdated());
      emit(UpdateQuantityError());
    }
  }

  bool checkIsInCart(String productId) {
    return cartProducts.any((product) => product.productId == productId);
  }

  // ================ Helper Methods ================ //

  String _encode(String value) => Uri.encodeComponent(value);

  void _handleAuthError() {
    _logError("User not authenticated");
    emit(CartError(message: "Authentication required"));
  }

  void _logDebug(String message) => log(message, name: 'CartCubit');

  void _logError(String message) =>
      log(message, name: 'CartCubit', error: message, level: 1000);
}
