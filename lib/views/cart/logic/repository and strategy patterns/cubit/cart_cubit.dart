// cart_cubit.dart
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/models/product_model.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cart_repository.dart';
import 'package:furniture_app/views/cart/logic/repository%20and%20strategy%20patterns/cubit/cart_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;
  final SupabaseClient _supabase;

  List<Products> cartProducts = [];
  String? get userId => _supabase.auth.currentUser?.id;

  CartCubit({
    required CartRepository cartRepository,
    required SupabaseClient supabase,
  })  : _cartRepository = cartRepository,
        _supabase = supabase,
        super(CartInitial()) {
    _initialize();
  }

  Future<void> _initialize() async {
    await getCartProducts();
  }

  // ================== Public Methods ================== //

  Future<void> getCartProducts() async {
    if (!_validateUser()) return;

    emit(GetCartLoading());
    cartProducts.clear();

    try {
      final cartItems = await _cartRepository.getCartItems(userId!);
      _handleCartItemsResponse(cartItems);
    } catch (e) {
      _handleError('Error fetching cart', e, GetCartError());
    }
  }

  Future<void> addToCart(String productId, int quantity) async {
    if (!_validateUser()) return;

    await _performCartOperation(
      operation: () => _cartRepository.addToCart(userId!, productId, quantity),
      loadingState: AddToCartLoading(),
      successState: AddToCartSuccess(),
      errorMessage: 'Add to cart failed',
    );
  }

  Future<void> removeFromCart(String productId) async {
    if (!_validateUser()) return;

    await _performCartOperation(
      operation: () => _cartRepository.removeFromCart(userId!, productId),
      loadingState: RemoveFromCartLoading(),
      successState: RemoveFromCartSuccess(),
      errorMessage: 'Remove from cart failed',
    );
  }

  Future<void> removeAllFromCart() async {
    if (!_validateUser()) return;

    await _performCartOperation(
      operation: () => _cartRepository.removeAllFromCart(userId!),
      loadingState: RemoveAllFromCartLoading(),
      successState: RemoveAllFromCartSuccess(),
      errorMessage: 'Remove all from cart failed',
    );
  }

  Future<void> updateQuantity(String productId, int newQuantity) async {
    if (!_validateUser()) return;

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
      await _cartRepository.updateQuantity(userId!, productId, newQuantity);
      emit(UpdateQuantitySuccess());
    } catch (e) {
      cartProducts[productIndex].quantity = previousQuantity;
      emit(CartUpdated());
      _handleError('Update quantity failed', e, UpdateQuantityError());
    }
  }

  bool checkIsInCart(String productId) {
    return cartProducts.any((product) => product.productId == productId);
  }

  // ================== Private Helpers ================== //

  bool _validateUser() {
    if (userId == null) {
      _handleAuthError();
      return false;
    }
    return true;
  }

  void _handleCartItemsResponse(List<Map<String, dynamic>> cartItems) {
    if (cartItems.isEmpty) {
      emit(GetCartSuccess());
      return;
    }

    cartProducts = cartItems
        .where((item) => item["product_id"] != null)
        .map((item) => Products.fromJson({
              ...Map<String, dynamic>.from(item["product_id"]),
              'quantity': item["quantity"] ?? 1,
            }))
        .toList();

    emit(GetCartSuccess());
  }

  Future<void> _performCartOperation({
    required Future<void> Function() operation,
    required CartState loadingState,
    required CartState successState,
    required String errorMessage,
  }) async {
    emit(loadingState);

    try {
      await operation();
      await getCartProducts();
      emit(successState);
    } catch (e) {
      _handleError(errorMessage, e, _errorStateFromLoadingState(loadingState));
    }
  }

  CartState _errorStateFromLoadingState(CartState loadingState) {
    return switch (loadingState) {
      AddToCartLoading() => AddToCartError(),
      RemoveFromCartLoading() => RemoveFromCartError(),
      RemoveAllFromCartLoading() => RemoveAllFromCartError(),
      _ => CartError(message: 'Operation failed'),
    };
  }

  void _handleError(String message, dynamic error, CartState errorState) {
    _logError('$message: $error');
    emit(errorState);
  }

  void _handleAuthError() {
    _logError('User not authenticated');
    emit(CartError(message: 'Authentication required'));
  }

  void _logError(String message) {
    log(message, name: 'CartCubit', level: 1000);
  }
}
