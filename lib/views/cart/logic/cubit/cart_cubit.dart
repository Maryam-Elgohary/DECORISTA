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
          "cart_table?select=*,product_id(*,category_table(*),product_image_table(*))&customer_id=eq.$userId");

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

  // Update quantity of product in cart
  Future<void> updateQuantity(String productId, int newQuantity) async {
    emit(UpdateQuantityLoading());
    try {
      // Send a PATCH request to update the quantity of the product in the cart
      await _apiServices.patchData(
        "cart_table?customer_id=eq.${Uri.encodeComponent(userId!)}&product_id=eq.${Uri.encodeComponent(productId)}",
        {"quantity": newQuantity},
      );

      // After updating, fetch the cart products again
      await getCartProducts();
      emit(UpdateQuantitySuccess());
    } catch (e) {
      log("Error updating quantity: $e");
      emit(UpdateQuantityError());
    }
  }
}
