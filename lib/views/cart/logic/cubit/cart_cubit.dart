import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:furniture_app/core/functions/api_services.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/cart/logic/cubit/cart_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final SupabaseClient _supabase = Supabase.instance.client;
  final ApiServices _apiServices = ApiServices();
  final String? userId = Supabase.instance.client.auth.currentUser?.id;
  List<Products> cartProducts = [];

  Future<void> getCartProducts() async {
    cartProducts = [];
    emit(GetCartLoading());

    log("User ID: $userId"); // Debugging statement
    if (userId == null) {
      log("Error: User ID is null. User might not be authenticated.");
      emit(GetCartError());
      return;
    }
    try {
      Response response = await _apiServices.getData(
          "cart_table?select=*,product_id(*,category_table(*),product_image_table(*),special_offers_table(*))&customer_id=eq.$userId");

      log("Cart API Response: ${response.data}");

      if (response.data.isNotEmpty) {
        for (var cartItem in response.data) {
          if (cartItem["product_id"] != null) {
            try {
              Map<String, dynamic> productData =
                  Map<String, dynamic>.from(cartItem["product_id"]);

              // Ensure quantity is properly added to the product data
              productData['quantity'] = cartItem["quantity"] ?? 1;

              Products product = Products.fromJson(productData);
              cartProducts.add(product);
            } catch (e) {
              log(" Error parsing product: $e");
            }
          }
          log(cartProducts.toString());
          emit(GetCartSuccess());
        }
      }
    } catch (e) {
      log(" Error fetching cart: $e");
      cartProducts = [];
      emit(GetCartError());
    }
  }

  Future<void> addToCart(String productId, int quantity) async {
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
      log(e.toString());
      emit(AddToCartError());
    }
  }

  Future<void> removeFromCart(String productId) async {
    emit(RemoveFromCartLoading());
    try {
      await _apiServices.deleteData(
          "cart_table?customer_id=eq.${Uri.encodeComponent(userId!)}&product_id=eq.${Uri.encodeComponent(productId)}");

      await getCartProducts();
      //  cartProducts.removeWhere((product) => product.productId == productId);

      emit(RemoveFromCartSuccess());
    } catch (e) {
      log(e.toString());
      emit(RemoveFromCartError());
    }
  }

  Future<void> removeAllFromCart() async {
    emit(RemoveAllFromCartLoading());
    try {
      await _apiServices.deleteData(
          "cart_table?customer_id=eq.${Uri.encodeComponent(userId!)}");

      await getCartProducts();

      emit(RemoveAllFromCartSuccess());
    } catch (e) {
      log(e.toString());
      emit(RemoveAllFromCartError());
    }
  }

  bool checkIsInCart(String productId) {
    getCartProducts();
    // Check if any product in the cart has the same productId
    return cartProducts.any((product) => product.productId == productId);
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    emit(UpdateQuantityLoading());

    int productIndex = -1; // Declare productIndex here
    int previousQuantity = 0; // Store the previous quantity

    try {
      // Step 1: Update the quantity locally
      productIndex = cartProducts.indexWhere((p) => p.productId == productId);
      if (productIndex != -1) {
        previousQuantity = cartProducts[productIndex].quantity ??
            1; // Store the previous quantity
        cartProducts[productIndex].quantity = newQuantity;
        emit(CartUpdated()); // Notify the UI of the local change
      }

      // Step 2: Sync the update with the server
      await _apiServices.patchData(
        "cart_table?customer_id=eq.${Uri.encodeComponent(userId!)}&product_id=eq.${Uri.encodeComponent(productId)}",
        {"quantity": newQuantity},
      );

      emit(UpdateQuantitySuccess());
    } catch (e) {
      log("Error updating quantity: $e");

      // Revert the local change if the server update fails
      if (productIndex != -1) {
        cartProducts[productIndex].quantity =
            previousQuantity; // Revert to the previous value
        emit(CartUpdated()); // Notify the UI of the reverted change
      }

      emit(UpdateQuantityError());
    }
  }
}
