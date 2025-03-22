part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetDataLoading extends HomeState {}

final class GetDataSuccess extends HomeState {
  final List<Products> products;

  GetDataSuccess(this.products);
}

final class GetDataError extends HomeState {}

final class AddToFavoriteLoading extends HomeState {}

final class AddToFavoriteSuccess extends HomeState {}

final class AddToFavoriteError extends HomeState {}

final class RemoveFromFavoriteLoading extends HomeState {}

final class RemoveFromFavoriteSuccess extends HomeState {}

final class RemoveFromFavoriteError extends HomeState {}

final class FavoriteUpdated extends HomeState {}

final class AddToCartLoading extends HomeState {}

final class AddToCartSuccess extends HomeState {}

final class AddToCartError extends HomeState {}

final class RemoveFromCartLoading extends HomeState {}

final class RemoveFromCartSuccess extends HomeState {}

final class RemoveFromCartError extends HomeState {}

class CategoryProductsCountUpdated extends HomeState {
  final int categoryProductCount;

  CategoryProductsCountUpdated(this.categoryProductCount);
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Map<String, dynamic>> products;

  HomeLoaded(this.products);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
