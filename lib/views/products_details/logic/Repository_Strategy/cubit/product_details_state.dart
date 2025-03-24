// product_details_state.dart

import 'package:flutter/material.dart';

@immutable
abstract class ProductDetailsState {
  const ProductDetailsState();
}

class ProductDetailsInitial extends ProductDetailsState {
  const ProductDetailsInitial();
}

class ProductDetailsLoading extends ProductDetailsState {}

class RatesLoaded extends ProductDetailsState {
  final int averageRate;
  final int userRate;

  const RatesLoaded({
    required this.averageRate,
    required this.userRate,
  });
}

class RateUpdateInProgress extends ProductDetailsState {}

class RateUpdateSuccess extends ProductDetailsState {}

class RateUpdateFailed extends ProductDetailsState {
  final String message;
  const RateUpdateFailed(this.message);
}

class CommentSubmissionInProgress extends ProductDetailsState {}

class CommentSubmissionSuccess extends ProductDetailsState {}

class CommentSubmissionFailed extends ProductDetailsState {
  final String message;
  const CommentSubmissionFailed(this.message);
}

class ProductDetailsError extends ProductDetailsState {
  final String message;
  const ProductDetailsError(this.message);
}
