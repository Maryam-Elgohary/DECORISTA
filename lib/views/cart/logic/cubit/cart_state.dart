import 'package:flutter/material.dart';
import 'package:furniture_app/core/models/product_model.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class GetCartLoading extends CartState {}

class GetCartSuccess extends CartState {}

class GetCartError extends CartState {}

class AddToCartLoading extends CartState {}

class AddToCartSuccess extends CartState {}

class AddToCartError extends CartState {}

class RemoveFromCartLoading extends CartState {}

class RemoveFromCartSuccess extends CartState {}

class RemoveFromCartError extends CartState {}

class UpdateQuantityLoading extends CartState {}

class UpdateQuantitySuccess extends CartState {}

class UpdateQuantityError extends CartState {}

class CartUpdated extends CartState {
  final List<Products> cartProducts;
  CartUpdated(this.cartProducts);
}

class RemoveAllFromCartLoading extends CartState {}

class RemoveAllFromCartSuccess extends CartState {}

class RemoveAllFromCartError extends CartState {}
