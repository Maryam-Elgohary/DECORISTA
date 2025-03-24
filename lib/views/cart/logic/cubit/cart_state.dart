import 'package:flutter/material.dart';

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

class CartUpdated extends CartState {}

class RemoveAllFromCartLoading extends CartState {}

class RemoveAllFromCartSuccess extends CartState {}

class RemoveAllFromCartError extends CartState {}
