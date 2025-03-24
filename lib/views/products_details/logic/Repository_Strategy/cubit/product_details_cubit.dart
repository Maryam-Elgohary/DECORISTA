// product_details_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/cubit/product_details_state.dart';
import 'package:furniture_app/views/products_details/logic/model/rate_model.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/product_repository.dart';
import 'package:furniture_app/views/products_details/logic/Repository_Strategy/rate_calculation_strategy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductRepository _repository;
  final RateCalculationStrategy _calculationStrategy;
  final String userId;

  List<Rate> rates = [];

  ProductDetailsCubit({
    required ProductRepository repository,
    RateCalculationStrategy? calculationStrategy,
    String? userId,
  })  : _repository = repository,
        _calculationStrategy = calculationStrategy ?? SimpleRateCalculation(),
        userId = userId ?? Supabase.instance.client.auth.currentUser!.id,
        super(ProductDetailsInitial());

  // Public methods
  Future<void> loadRates(String productId) async {
    emit(ProductDetailsLoading());
    try {
      rates = await _repository.getRates(productId);
      emit(RatesLoaded(
        averageRate: _calculationStrategy.calculateAverage(rates),
        userRate: _calculationStrategy.getUserRate(rates, userId),
      ));
    } catch (e) {
      emit(ProductDetailsError('Failed to load ratings'));
    }
  }

  Future<void> submitRating({
    required String productId,
    required int rating,
  }) async {
    emit(RateUpdateInProgress());
    try {
      final data = {
        'rate': rating,
        'user_id': userId,
        'product_id': productId,
      };

      if (_calculationStrategy.userRateExists(rates, userId, productId)) {
        await _repository.updateRate(productId, data);
      } else {
        await _repository.addRate(productId, data);
      }

      await loadRates(productId); // Refresh data
      emit(RateUpdateSuccess());
    } catch (e) {
      emit(RateUpdateFailed('Failed to update rating'));
    }
  }

  Future<void> submitComment(Map<String, dynamic> data) async {
    emit(CommentSubmissionInProgress());
    try {
      await _repository.addComment(data);
      emit(CommentSubmissionSuccess());
    } catch (e) {
      emit(CommentSubmissionFailed('Failed to submit comment'));
    }
  }
}
